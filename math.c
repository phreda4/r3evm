x, y: 64-bit integer
x_h/x_l: higher/lower 32 bits of x
y_h/y_l: higher/lower 32 bits of y

x*y  = ((x_h*2^32 + x_l)*(y_h*2^32 + y_l)) mod 2^64
     = (x_h*y_h*2^64 + x_l*y_l + x_h*y_l*2^32 + x_l*y_h*2^32) mod 2^64
     = x_l*y_l + (x_h*y_l + x_l*y_h)*2^32

Now from the equation you can see that only 3(not 4) multiplication needed.

 movl 16(%ebp), %esi    ; get y_l
 movl 12(%ebp), %eax    ; get x_l
 movl %eax, %edx
 sarl $31, %edx         ; get x_h, (x >>a 31), higher 32 bits of sign-extension of x
 movl 20(%ebp), %ecx    ; get y_h
 imull %eax, %ecx       ; compute s: x_l*y_h
 movl %edx, %ebx
 imull %esi, %ebx       ; compute t: x_h*y_l
 addl %ebx, %ecx        ; compute s + t
 mull %esi              ; compute u: x_l*y_l
 leal (%ecx,%edx), %edx ; u_h += (s + t), result is u
 movl 8(%ebp), %ecx
 movl %eax, (%ecx)
 movl %edx, 4(%ecx)
 
 
 inline
unsigned int __shld(unsigned int into, unsigned int from, unsigned int c)
{
   unsigned int res;

   if (__builtin_constant_p(into) &&
       __builtin_constant_p(from) &&
       __builtin_constant_p(c))
   {
      res = (into << c) | (from >> (32 - c));
   }
   else
   {
      asm("shld %b3, %2, %0"
          : "=rm" (res)
          : "0" (into), "r" (from), "ic" (c)
          : "cc");
   }

   return res;
}

inline
unsigned int __shrd(unsigned int into, unsigned int from, unsigned int c)
{
   unsigned int res;

   if (__builtin_constant_p(into) && 
       __builtin_constant_p(from) && 
       __builtin_constant_p(c))
   {
      res = (into >> c) | (from << (32 - c));
   }
   else
   {
      asm("shrd %b3, %2, %0"
          : "=rm" (res)
          : "0" (into), "r" (from), "ic" (c)
          : "cc");
   }

   return res;
}

my_uint128_t lshift_uint128 (const my_uint128_t a, unsigned int b)
{
   my_uint128_t res;

   if (b < 32) {
      res.x = a.x << b;
      res.y = __shld(a.y, a.x, b);
      res.z = __shld(a.z, a.y, b);
      res.w = __shld(a.w, a.z, b);
   } else if (b < 64) {
      res.x = 0;
      res.y = a.x << (b - 32);
      res.z = __shld(a.y, a.x, b - 32);
      res.w = __shld(a.z, a.y, b - 32);
   } else if (b < 96) {
      res.x = 0;
      res.y = 0;
      res.z = a.x << (b - 64);
      res.w = __shld(a.y, a.x, b - 64);
   } else if (b < 128) {
      res.x = 0;
      res.y = 0;
      res.z = 0;
      res.w = a.x << (b - 96);
   } else {
      memset(&res, 0, sizeof(res));
   }

   return res;
}

my_uint128_t rshift_uint128 (const my_uint128_t a, unsigned int b)
{
   my_uint128_t res;

   if (b < 32) {
      res.x = __shrd(a.x, a.y, b);
      res.y = __shrd(a.y, a.z, b);
      res.z = __shrd(a.z, a.w, b);
      res.w = a.w >> b;
   } else if (b < 64) {
      res.x = __shrd(a.y, a.z, b - 32);
      res.y = __shrd(a.z, a.w, b - 32);
      res.z = a.w >> (b - 32);
      res.w = 0;
   } else if (b < 96) {
      res.x = __shrd(a.z, a.w, b - 64);
      res.y = a.w >> (b - 64);
      res.z = 0;
      res.w = 0;
   } else if (b < 128) {
      res.x = a.w >> (b - 96);
      res.y = 0;
      res.z = 0;
      res.w = 0;
   } else {
      memset(&res, 0, sizeof(res));
   }

   return res;
}

class int128_t
{
    uint32_t dw3, dw2, dw1, dw0;

    // Various constrctors, operators, etc...

    int128_t& operator*=(const int128_t&  rhs) __attribute__((always_inline))
    {
        int128_t Urhs(rhs);
        uint32_t lhs_xor_mask = (int32_t(dw3) >> 31);
        uint32_t rhs_xor_mask = (int32_t(Urhs.dw3) >> 31);
        uint32_t result_xor_mask = (lhs_xor_mask ^ rhs_xor_mask);
        dw0 ^= lhs_xor_mask;
        dw1 ^= lhs_xor_mask;
        dw2 ^= lhs_xor_mask;
        dw3 ^= lhs_xor_mask;
        Urhs.dw0 ^= rhs_xor_mask;
        Urhs.dw1 ^= rhs_xor_mask;
        Urhs.dw2 ^= rhs_xor_mask;
        Urhs.dw3 ^= rhs_xor_mask;
        *this += (lhs_xor_mask & 1);
        Urhs += (rhs_xor_mask & 1);

        struct mul128_t
        {
            int128_t dqw1, dqw0;
            mul128_t(const int128_t& dqw1, const int128_t& dqw0): dqw1(dqw1), dqw0(dqw0){}
        };

        mul128_t data(Urhs,*this);
        asm volatile(
        "push      %%ebp                            \n\
        movl       %%eax,   %%ebp                   \n\
        movl       $0x00,   %%ebx                   \n\
        movl       $0x00,   %%ecx                   \n\
        movl       $0x00,   %%esi                   \n\
        movl       $0x00,   %%edi                   \n\
        movl   28(%%ebp),   %%eax #Calc: (dw0*dw0)  \n\
        mull             12(%%ebp)                  \n\
        addl       %%eax,   %%ebx                   \n\
        adcl       %%edx,   %%ecx                   \n\
        adcl       $0x00,   %%esi                   \n\
        adcl       $0x00,   %%edi                   \n\
        movl   24(%%ebp),   %%eax #Calc: (dw1*dw0)  \n\
        mull             12(%%ebp)                  \n\
        addl       %%eax,   %%ecx                   \n\
        adcl       %%edx,   %%esi                   \n\
        adcl       $0x00,   %%edi                   \n\
        movl   20(%%ebp),   %%eax #Calc: (dw2*dw0)  \n\
        mull             12(%%ebp)                  \n\
        addl       %%eax,   %%esi                   \n\
        adcl       %%edx,   %%edi                   \n\
        movl   16(%%ebp),   %%eax #Calc: (dw3*dw0)  \n\
        mull             12(%%ebp)                  \n\
        addl       %%eax,   %%edi                   \n\
        movl   28(%%ebp),   %%eax #Calc: (dw0*dw1)  \n\
        mull              8(%%ebp)                  \n\
        addl       %%eax,   %%ecx                   \n\
        adcl       %%edx,   %%esi                   \n\
        adcl       $0x00,   %%edi                   \n\
        movl   24(%%ebp),   %%eax #Calc: (dw1*dw1)  \n\
        mull              8(%%ebp)                  \n\
        addl       %%eax,   %%esi                   \n\
        adcl       %%edx,   %%edi                   \n\
        movl   20(%%ebp),   %%eax #Calc: (dw2*dw1)  \n\
        mull              8(%%ebp)                  \n\
        addl       %%eax,   %%edi                   \n\
        movl   28(%%ebp),   %%eax #Calc: (dw0*dw2)  \n\
        mull              4(%%ebp)                  \n\
        addl       %%eax,   %%esi                   \n\
        adcl       %%edx,   %%edi                   \n\
        movl   24(%%ebp),  %%eax #Calc: (dw1*dw2)   \n\
        mull              4(%%ebp)                  \n\
        addl       %%eax,   %%edi                   \n\
        movl   28(%%ebp),   %%eax #Calc: (dw0*dw3)  \n\
        mull               (%%ebp)                  \n\
        addl       %%eax,   %%edi                   \n\
        pop        %%ebp                            \n"
        :"=b"(this->dw0),"=c"(this->dw1),"=S"(this->dw2),"=D"(this->dw3)
        :"a"(&data):"%ebp");

        dw0 ^= result_xor_mask;
        dw1 ^= result_xor_mask;
        dw2 ^= result_xor_mask;
        dw3 ^= result_xor_mask;
        return (*this += (result_xor_mask & 1));
    }
};
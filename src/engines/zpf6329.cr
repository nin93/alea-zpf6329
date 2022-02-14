require "alea"

module Alea
  class ZPF6329
    include Alea::PRNG(UInt32, UInt64)

    STATE_STORAGE_32 = 4
    STATE_STORAGE_64 = 2

    # The state this PRNG refers to when called for generating `UInt32`s.
    @state32 : StaticArray(UInt32, STATE_STORAGE_32)

    # The state this PRNG refers to when called for generating `UInt64`s.
    @state64 : StaticArray(UInt64, STATE_STORAGE_64)

    # The seed this PRNG received to initialize `@state32`.
    @seed32 : UInt32

    # The seed this PRNG received to initialize `@state64`.
    @seed64 : UInt64

    # Initializes the PRNG with initial seeds.
    #
    # **@parameters**:
    # * `seed32`: value as input to init. the state of 32-bit generators.
    # * `seed64`: value as input to init. the state of 64-bit generators.
    #
    # **@references**:
    # * `Alea::Mulberry32(4)#init_state`.
    # * `Alea::SplitMix64(2)#init_state`.
    #
    # **@exceptions**:
    # * `Alea::UndefinedError` if any of `seed32` or `seed64` is negative.
    def initialize(@seed32 : UInt32, @seed64 : UInt64)
      @state32 = Alea::Core::Mulberry32(STATE_STORAGE_32).init_state @seed32
      @state64 = Alea::Core::SplitMix64(STATE_STORAGE_64).init_state @seed64
    end

    # Generate a uniform-distributed random `UInt32`.
    #
    # **@examples**:
    # ```
    # rng = Alea::ZPF6329.new
    # rng.next_u32 # => 1767702788
    # ```
    @[AlwaysInline]
    def next_u32 : UInt32
      dust0, dust1, *_ = @state32
      random = rotate(dust0 &+ dust1, 9, size: 32) &+ dust0
      next_state_32
      random 
    end

    # Generate a uniform-distributed random `UInt64`.
    #
    # **@examples**:
    # ```
    # rng = Alea::ZPF6329.new
    # rng.next_u64 # => 9136120204379184874
    # ```
    @[AlwaysInline]
    def next_u64 : UInt64
      dust0, dust1, *_ = @state64
      random = rotate(dust0 &+ dust1, 12, size: 64) &+ dust0
      next_state_64
      random 
    end

    @[AlwaysInline]
    protected def rotate(x : Int, k : Int32, size : Int32) : Int
      (x << k) | (x >> (size - k))
    end

    @[AlwaysInline]
    protected def next_state_32 : Nil
      dust = @state32[1] << 9
      @state32[1] ^= @state32[0]
      @state32[3] ^= @state32[2]
      @state32[2] ^= @state32[1]
      @state32[0] ^= @state32[3]
      @state32[2] ^= dust
      @state32[3] = rotate(@state32[3], 12, size: 32)
    end

    @[AlwaysInline]
    protected def next_state_64 : Nil
      dust0, dust1, *_ = @state64
      dust1 ^= dust0
      @state64[0] = rotate(dust0, 53, size: 64) ^ dust1 ^ (dust1 << 12)
      @state64[1] = rotate(dust1, 23, size: 64)
    end
  end
end

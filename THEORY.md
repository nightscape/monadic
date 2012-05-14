# Functors, Monads, Applicative Functors

Context - often called Box in Monad tutorials.

## Functor
Use if you want to apply a function to things in some context.

Basically a Functor is a _box_ which can be _mapped_ over. It defines a `map` function.

    A -> B -> C[A] - C[B]

    # Haskell
    class Functor f where 
      fmap :: (a -> b) -> f a -> f b

    # Scala
    def map[A,B](f: A => B)(a: T[A]): T[B] 

    # Ruby
    def map(f)
      self.class.unit(@value)
    end


## Applicative Functor

An Applicative Functor - as the name might suggest - is already a Functor.  

It defines a `unit` function to put things into a context.

    C[A -> B] -> C[A] -> C[B]

    # Ruby
    def self.unit(value)
      @value = value
    end

## Monads

Monads are Applicative Functors with an additional `bind` function.  

It defines a `bind` (aka `chain`) function and the `return` or `inject` function, which I renamed to `fetch` in idiomatic ruby.  
 
    # Haskell
    class Monad m where
        -- chain
        (>>=)  :: m a -> (a -> m b) -> m b
        -- inject
        return :: a -> m a

    # Ruby
    def Monad.fetch

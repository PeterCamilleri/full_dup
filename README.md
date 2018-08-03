# FullDup

The full_dup gem adds the full_dup method to all objects descended from the
Object class. While this gem makes extensive use of monkey patching, it does
not modify the behaviour of any existing methods. This is done to minimize
the risk of breaking any existing code.

The standard dup method creates a fresh instance of most (non-scalar) objects
but does not process internal state. This internal state remains aliased in the
duplicated copy. The full_dup method digs deep and makes copies of these
internal variables, not just arrays and hashes. It also allows classes to
specify an exclusion list of variables that are not to be processed.

This comprehensive approach creates another issue to be resolved. In Ruby, if an
attempt is made to dup an immutable data item like a number, an error occurs.
The justification for this uncharacteristic strictness is not at all clear, but
it does mean that the dup operation must be applied with great care.

Unlike the standard dup method, the full\_dup method does not throw an
exception when it sees un-duppable value objects like 42 or true. These values
simply return themselves. This is deemed correct because those types of objects
are immutable and do not need to be duped. Instead of raising an exception,
the code returns the immutable object instead.

Another issue that this gem deals with is that of data with looping reference
chains. To handle this, the code tracks object ID values and does not re-dup
data that has already been duped. Thus even nasty edge cases are handled
without any special effort on the part of the application programmer. Note though
that this also means that it is important that the object id be correctly
implemented. Fortunately, this is done by default in Ruby.

If you wish to implement your own object id for your own special classes:
1. Don't! If object_id is broken,
then full_dup (and a whole lot of other things too) will also be broken!
2. It's all on you to do as good a job as Ruby. Like the Ruby object id method,
your method must create id values that are unique to each object and are perfectly
repeatable for that object.
3. Really DON'T! I have never found a valid reason for doing so. I doubt that one exists.

## Family Overview

This gem is a member of a family of four gems that all provide data copying
services in a safe, easy to use format. The following outlines the available
gems and how to chose from among them.

Depth / Action | Need to copy all. | Need to copy data only.
---------------|------------------------------|------------
Need a shallow copy | require 'safe\_clone' | require 'safe\_dup'
Need a full copy    | require 'full\_clone' | require 'full\_dup'

<br>**Notes**
* Since none of these gems override the default clone and dup
methods, the default behaviors remain available. Further, if multiple,
differing requirements exists, more than one family member gem may be
employed in the same project without fear of conflict.
* If multiple family gems are employed, they will each need to be installed and
required into the application. See below for details.
* Meta-data attributes include the frozen status and singleton methods. However
the tainted status is always copied.


## Installation

Add this line to your application's Gemfile:

```ruby
gem 'full_dup'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install full_dup

The safe_dup gem is at: ( https://rubygems.org/gems/safe_dup )
<br>The safe_clone gem is at: ( https://rubygems.org/gems/safe_clone )
<br>The full_dup gem is at: ( https://rubygems.org/gems/full_dup )
<br>The full_clone gem is at: ( https://rubygems.org/gems/full_clone )

## Usage

    require 'full_dup'

then, in those places where regular dup was problematic, use:

    foo = my_object.full_dup

instead of

    foo = my_object.dup

To exclude some instance variables from the deep duplicating process, define a
full_dup_exclude method in the required class:

```ruby
def full_dup_exclude
  [:@bad_var1, :@bad_var2, :@bad_var_etc]
end
```
This also can be applied to arrays and hashes. In this case, it is possible to
define a singleton method on the duped data. Then the exclude method would
return an array of array indexes or hash keys to be omitted from the full dup
recursion. Here is an example that never dupes the first two elements of the
array:

```ruby
my_array.define_singleton_method(:full_dup_exclude) { [0, 1] }
```
<br>**Possible Red Flag** There is a catch here. The dup and full_dup methods
do not duplicate singleton methods (unlike the clone and full_clone methods).
Thus any duplicates made in this manner will lose the attached full_dup_exclude
method. If it is important to retain singleton methods, consider using the
full_clone gem instead.

### irbt

The root folder of the full_dup gem contains the file irbt.rb. This program
opens up the irb repl with the full_dup gem preloaded and is useful for trying
out the gem interactively.

By default, irbt will load the system gem version of full dup. The following
interactive session demonstrates the difference between dup and full_dup

```
C:\Sites\full_dup>ruby irbt.rb
Starting an IRB console with full_dup loaded.
full_dup loaded from gem: 0.0.5
irb(main):001:0> a = ["a", "b", "c"]
=> ["a", "b", "c"]
irb(main):002:0> b = a.dup
=> ["a", "b", "c"]
irb(main):003:0> c = a.full_dup
=> ["a", "b", "c"]
irb(main):004:0> a[0] << "foo"
=> "afoo"
irb(main):005:0> a
=> ["afoo", "b", "c"]
irb(main):006:0> b
=> ["afoo", "b", "c"]
irb(main):007:0> c
=> ["a", "b", "c"]
irb(main):008:0>
```
To load the local copy of full_dup use:
```
>ruby irbt.rb local #optional irb args go here.
#etc etc etc...
```

## Contributing

#### Plan A

1. Fork it ( https://github.com/PeterCamilleri/full_dup/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request

#### Plan B

Go to the GitHub repository and raise an issue calling attention to some
aspect that could use some TLC or a suggestion or an idea.

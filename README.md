# data.cr

Data Structures for Crystal Lang. A very modest start.

## What's New

- 02/04/17: Scala-like Lists and Stacks
- 02/01/17: Second check-in: a modest, not thoroughly tested immutable map
- 01/21/17: First check-in: AVL tree


## Installation

Add these package to your dependencies in shard.yml:

    dependencies:
      data:
        github: fusion/data.cr


## Usage

Include, use. See examples/{avltree.cr, map.cr, list.cr, stack.cr}

Also `crystal spec`

## Data Structures:

They are all enumerables and can be walked, filtered, etc.

### Mutable

These serve as the backbone for the immutable ones:

- Tree, AVLTree, LinkedList

### Persistent

- Map
- List
- Stack

## To do

* List (done), Queue, Stack (done), Vector (important!)
* Proper iterators

## Contributing

1. Fork it ( https://github.com/fusion/data.cr/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request

## Contributors

- [[fusion]](https://github.com/fusion) Chris F Ravenscroft - creator, maintainer

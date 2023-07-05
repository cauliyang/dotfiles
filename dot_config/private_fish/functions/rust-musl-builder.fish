function rust-musl-builder --wraps='docker run --rm -it -v "$(pwd)":/home/rust/src messense/rust-musl-cross:x86_64-musl' --description 'alias rust-musl-builder=docker run --rm -it -v "$(pwd)":/home/rust/src messense/rust-musl-cross:x86_64-musl'
  docker run --rm -it -v "$(pwd)":/home/rust/src messense/rust-musl-cross:x86_64-musl $argv
        
end

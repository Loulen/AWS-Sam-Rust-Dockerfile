FROM public.ecr.aws/sam/build-provided

#Installing rust
RUN curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs > rust-install.sh
RUN sh rust-install.sh -y

#Installing build dependencies
# Zig is used for cross compilation to a lambda environment
RUN curl https://ziglang.org/download/0.9.1/zig-linux-x86_64-0.9.1.tar.xz --output /tmp/zig-linux-x86_64-0.9.1.tar.xz
RUN tar -xf /tmp/zig-linux-x86_64-0.9.1.tar.xz -C /usr/local \
    && rm -f /tmp/zig-linux-x86_64-0.9.1.tar.xz \
    && rm -rf zig-linux-x86_64-0.9.1

#updating path
ENV PATH="${PATH}:/root/.cargo/bin:/usr/local/zig-linux-x86_64-0.9.1"

RUN cargo install cargo-lambda
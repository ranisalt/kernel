FROM archlinux/base

RUN useradd -M builduser && \
    mkdir /etc/sudoers.d && \
    echo "builduser ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/builduser && \
    pacman -Syuq base-devel ccache --needed --noconfirm && \
    sed -i -e '/#MAKEFLAGS/a MAKEFLAGS=-j2/' -e 's/!ccache/ccache/' /etc/makepkg.conf

COPY --chown=builduser trunk /trunk/

USER builduser
WORKDIR /trunk

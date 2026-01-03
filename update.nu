export def grub [] {
    sudo grub-mkconfig -o /boot/grub/grub.cfg
}

export def kwin-effects [] {
    yay -S ...(yay -Qq | find kwin-effect --no-highlight | where $it !~ ".*?-debug")
}

export def debug-packages [] {
    let debug_packages = yay -Qqs ".*-debug" | lines
    let packages = yay -Qq | lines
    yay -Rsc ...($debug_packages | parse "{package}-debug" | where package not-in $packages | each {|x| $"($x.package)-debug" })
}

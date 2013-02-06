require 'formula'

class Ninja < Formula
  homepage 'https://github.com/martine/ninja'
  head 'git://github.com/martine/ninja.git'
  url 'https://github.com/martine/ninja/tarball/v1.1.0'
  sha1 '491b087d124c832f83a427d424b5e48f0f3803c3'

  def install
    system "./bootstrap.py"
    bin.install "ninja"
    bash_completion.install 'misc/bash-completion' => 'ninja-completion.sh'
  end
end

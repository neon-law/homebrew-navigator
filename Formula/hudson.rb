class Hudson < Formula
  desc "Neon Law Navigator operator CLI"
  # The product page; `webapp::source_repository::NAVIGATOR_HREF` is the same
  # URL the public footer links.
  homepage "https://www.neonlaw.com/navigator"
  version "26.11.22-rc.2"
  # The installed CLI offers either license; the tap has its own terms.
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/neon-law/navigator/releases/download/26.11.22-rc.2/hudson-26.11.22-rc.2-macos.tar.gz"
      sha256 "31c96b77f8905b58587197f087dc09da631756c886ff2276e26cfdd339847c8b"
    end

    on_intel do
      # No prebuilt archive exists for Intel macOS — `macos-latest` is Apple
      # silicon — and this formula does not compile from source.
      odie "no prebuilt hudson archive exists for Intel macOS, and this " \
           "formula no longer compiles one from source. Install on Apple " \
           "silicon or x86_64 Linux instead, or use the Linux install script " \
           "(see docs/gitops.md's Homebrew tap section in the Navigator " \
           "repository) inside a container or VM on this machine."
    end
  end

  on_linux do
    on_intel do
      url "https://github.com/neon-law/navigator/releases/download/26.11.22-rc.2/hudson-26.11.22-rc.2-linux.tar.gz"
      sha256 "b6b8c5aac8ae65168a1d0a452134f93269b73b71591de38cef25a235cf386bab"
    end

    on_arm do
      # Same reasoning as Intel macOS above: the release publishes x86_64
      # Linux only, and there is no source-tag fallback left to compile.
      odie "no prebuilt hudson archive exists for arm64 Linux, and this " \
           "formula no longer compiles one from source. Install on x86_64 " \
           "Linux or Apple silicon instead."
    end
  end

  def install
    # Every supported platform now installs the same way: the one prebuilt
    # archive its `on_macos`/`on_linux` block named. Nothing reaches `install`
    # for Intel macOS or arm64 Linux — the `odie` calls above abort before
    # Homebrew gets here — so there is no second branch to keep in sync with
    # them.
    bin.install "hudson"

    # Stage the CLI's own license grants and notices from the release archive.
    prefix.install "LICENSE", "LICENSE-MIT", "LICENSE-APACHE-2", "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/hudson --version")
    %w[LICENSE LICENSE-MIT LICENSE-APACHE-2 NOTICE].each do |name|
      assert_path_exists prefix/name
      refute_empty (prefix/name).read
    end
  end
end

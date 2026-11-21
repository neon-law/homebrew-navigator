class Hudson < Formula
  desc "Neon Law Navigator operator CLI"
  # The product page; `webapp::source_repository::NAVIGATOR_HREF` is the same
  # URL the public footer links.
  homepage "https://www.neonlaw.com/navigator"
  version "26.11.21-rc.4"
  # The installed CLI offers either license; the tap has its own terms.
  license any_of: ["MIT", "Apache-2.0"]

  on_macos do
    on_arm do
      url "https://github.com/neon-law/navigator/releases/download/26.11.21-rc.4/hudson-26.11.21-rc.4-macos.tar.gz"
      sha256 "e58a6fd1bb8a2d61a14844d6d2a862fb913bcbdca5f5f0945bc51321df4fc4c6"
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
      url "https://github.com/neon-law/navigator/releases/download/26.11.21-rc.4/hudson-26.11.21-rc.4-linux.tar.gz"
      sha256 "03bbdbc0d0352328d8b2d75247cf9fdb57f399070af5d63f75f62b7045da07fa"
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

class Scorpio < Formula
  desc "Neon Law Navigator Ephemeris CLI"
  homepage "https://www.neonlaw.com/navigator"
  url "https://github.com/neon-law/navigator/releases/download/26.11.22-rc.2/scorpio-26.11.22-rc.2-linux.tar.gz"
  version "26.11.22-rc.2"
  sha256 "beb395c661fe7a02da82f465a8180ddc864b62b99e15bca365fc390cdc2f9cc4"
  license any_of: ["MIT", "Apache-2.0"]

  depends_on arch: :x86_64
  depends_on :linux

  def install
    bin.install "scorpio"
    prefix.install "LICENSE", "LICENSE-MIT", "LICENSE-APACHE-2", "NOTICE"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scorpio --version")
    %w[LICENSE LICENSE-MIT LICENSE-APACHE-2 NOTICE].each do |name|
      assert_path_exists prefix/name
      refute_empty (prefix/name).read
    end
  end
end

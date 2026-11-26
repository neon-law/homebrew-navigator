class Scorpio < Formula
  desc "Neon Law Navigator Ephemeris CLI"
  homepage "https://www.neonlaw.com/navigator"
  url "https://github.com/neon-law/navigator/releases/download/26.11.26/scorpio-26.11.26-linux.tar.gz"
  version "26.11.26"
  sha256 "75d4a8f06bc082963400aeae3c2fed58b96bbd232459b1515a97687c72973cab"
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

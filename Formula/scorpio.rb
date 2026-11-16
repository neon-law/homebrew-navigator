class Scorpio < Formula
  desc "Neon Law Navigator Ephemeris CLI"
  homepage "https://www.neonlaw.com/navigator"
  url "https://github.com/neon-law/navigator/releases/download/26.11.17-rc.1/scorpio-26.11.17-rc.1-linux.tar.gz"
  version "26.11.17-rc.1"
  sha256 "e58317642e3f654c5b4173a08db7cbc5f4458e2803de742cb0b628901a8f349c"
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

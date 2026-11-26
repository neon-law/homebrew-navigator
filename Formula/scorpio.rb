class Scorpio < Formula
  desc "Neon Law Navigator Ephemeris CLI"
  homepage "https://www.neonlaw.com/navigator"
  url "https://github.com/neon-law/navigator/releases/download/26.11.26-rc.1/scorpio-26.11.26-rc.1-linux.tar.gz"
  version "26.11.26-rc.1"
  sha256 "265868982c60cd402db0ae5ba92e3ecfaadbfa8993d69013af4163d509b5fb58"
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

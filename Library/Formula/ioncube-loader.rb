require 'formula'
require 'hardware'

class IoncubeLoader < Formula
  homepage 'http://www.ioncube.com/'

  packages = {
    :x86_64 => {
      :url => 'http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_dar_x86-64.tar.gz',
      :md5 => '7031f1bd001062529273b93325954cfc',
      :version => '4.0.8-x86_64'
    },
    :i386 => {
      :url => 'http://downloads2.ioncube.com/loader_downloads/ioncube_loaders_dar_x86.tar.gz',
      :md5 => '8de18008a1f8a71320318631dd737e14',
      :version => '4.0.8-i386'
    }
  }

  package = (Hardware.is_64_bit? and not ARGV.include? '--32bit') ? packages[:x86_64] : packages[:i386]

  url     package[:url]
  md5     package[:md5]
  version package[:version]

  def install
    prefix.install 'ioncube_loader_dar_5.3.so'
    prefix.install 'ioncube_loader_dar_5.3_ts.so'
    prefix.install 'ioncube_loader_dar_5.2.so'
    prefix.install 'ioncube_loader_dar_5.2_ts.so'
  end

  def caveats
      <<-EOS
To use this software:
 * Add the following line to php.ini:
    zend_extension="#{prefix}/ioncube_loader_dar_5.3.so"
 * The ionCube Loader must be the first Zend extension listed in the php.ini configuration file
 * Restart your webserver.
 * Write a PHP page that calls "phpinfo();"
 * Load it in a browser and look for the info on the ioncube module.
 * If you see it, you have been successful!
      EOS
  end
end

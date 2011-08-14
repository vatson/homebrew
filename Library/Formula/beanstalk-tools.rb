require 'formula'

class BeanstalkTools < Formula
  head 'https://github.com/dustin/beanstalk-tools.git'
  homepage 'https://github.com/dustin/beanstalk-tools'

  def install
    prefix.install Dir['*']
    ln_s "#{bin}/*", "#{HOMEBREW_PREFIX}/bin" 
  end  
end

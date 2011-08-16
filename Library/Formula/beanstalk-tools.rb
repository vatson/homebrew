require 'formula'

def BeanstalkClient_Installed?;
  begin
    require 'rubygems'
  rescue Exception
    onoe <<-EOS.undent
       This package requires installed rubygems. Please install rubygems and repeat installation
      EOS
    exit 1
  end

 begin
   Gem::Specification::find_by_name('beanstalk-client')
 rescue Gem::LoadError
   return false
 end
end

class BeanstalkTools < Formula
  head 'https://github.com/dustin/beanstalk-tools.git'
  homepage 'https://github.com/dustin/beanstalk-tools'

  depends_on 'beanstalk'

  def install

    unless BeanstalkClient_Installed?
      onoe <<-EOS.undent
        This package requires beanstalk-client gem. Please install this gem:

          gem install beanstalk-client

        and repeat installation
      EOS
      exit 1
    end

    prefix.install Dir['*']
  end
end
require 'formula'

class W3af <Formula
  url 'http://downloads.sourceforge.net/project/w3af/w3af/w3af%201.0-rc3%20%5Bmoyogui%5D/w3af-1.0-rc3.tar.bz2'
  homepage 'http://http://w3af.sourceforge.net/'
  md5 '0a6e803636ab3b46ec950c07e6d4baf5'
  
  def patches
    DATA
  end

  def install
    libexec.install Dir["w3af_*",'core','extlib','locales','plugins','profiles','readme','scripts','tools']
    bin.mkpath
    Dir["#{libexec}/w3af_*"].each {|f| ln_s f, bin}
  end

  def caveats; <<-EOS.undent
    You may need to install these python packages:
        
        pygoogle
            easy_install http://downloads.sourceforge.net/project/pygoogle/pygoogle/0.6/pygoogle-0.6.zip

        fpconst
            easy_install http://pypi.python.org/packages/source/f/fpconst/fpconst-0.7.2.tar.gz

        SOAPpy
            curl -L -O http://downloads.sourceforge.net/project/pywebsvcs/SOAP.py/0.11.6/SOAPpy-0.11.6.tar.gz
            tar xvf SOAPpy-0.11.6.tar.gz
            cd SOAPpy-0.11.6
            curl -O http://gist.github.com/raw/536606/3853b5ed1ee1b11325f2cd4be6cecc933661124b/SOAPpy-patch.diff
            patch -p1 < SOAPpy-patch.diff
            ./setup.py install
        
        ntlk
            easy_install http://pyyaml.org/download/pyyaml/PyYAML-3.09.tar.gz
            easy_install http://nltk.googlecode.com/files/nltk-2.0b9.zip

        pyPDF
            easy_install http://pybrary.net/pyPdf/pyPdf-1.12.tar.gz

        Beautiful Soup
            easy_install http://www.crummy.com/software/BeautifulSoup/download/3.1.x/BeautifulSoup-3.1.0.1.tar.gz

        Python OpenSSL
            easy_install http://pypi.python.org/packages/source/p/pyOpenSSL/pyOpenSSL-0.10.tar.gz

        json-py
            This package doesn't support easy_install or setup tools, and
            requires a manual install which involves copying json.py to the
            python site-packages directory.

            curl -L -O http://downloads.sourceforge.net/project/json-py/json-py/3_4/json-py-3_4.zip
            unzip -d json-py-3_4 json-py-3_4.zip
            cp json-py-3_4/json.py /Library/Python/2.6/site-packages/

        Scapy
            easy_install http://www.secdev.org/projects/scapy/files/scapy-latest.tar.gz
    EOS
  end
end

__END__
diff --git a/w3af_console b/w3af_console
index a22c30b..d9ac576 100755
--- a/w3af_console
+++ b/w3af_console
@@ -2,10 +2,11 @@
 
 import getopt, sys, os
 import gettext
+import commands
  
 # First of all, we need to change the working directory to the directory of w3af.
 currentDir = os.getcwd()
-scriptDir = os.path.dirname(sys.argv[0]) or '.'
+scriptDir = commands.getoutput('brew --prefix w3af') + '/libexec'
 os.chdir( scriptDir )
 
 def backToCurrentDir():

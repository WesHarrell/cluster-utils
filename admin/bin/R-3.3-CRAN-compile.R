## Central Install R modules script
# Install all new and updated R modules from a number of repos to NFS


# Global option to not test before loading.  We might get a few broken pkgs but
# we also get some packages
# that build OK but for some reason fail a test.  We can look into these if
# users complain.

options( INSTALL_opts = "--no-test-load" )
options( download.file.method = "wget")


##
## CRAN repo
#
#options( repos = "ftp://mirror.hmdc.harvard.edu/CRAN" )
options( repos = "http://lib.stat.cmu.edu/R/CRAN/" )
# Get new modules
plist <- new.packages(lib.loc = "/home/software/sloan/local/lib/R/3.3")
sapply(plist,function(x){try(install.packages(x,lib="/home/software/sloan/local/lib/R/3.3"))})
# Get updated modules
ulist <- old.packages(lib.loc = "/home/software/sloan/local/lib/R/3.3")
sapply(ulist,function(x){try(install.packages(x,lib="/home/software/sloan/local/lib/R/3.3"))})
#
# Add useful tools from non-CRAN repo
library("devtools")
devtools::install_github("hadley/multidplyr", lib="/home/software/sloan/local/lib/R/3.3")
devtools::install_github('IRkernel/IRkernel',lib="/home/software/sloan/local/lib/R/3.3")
#IRkernel::installspec()  # to register the kernel in the current R installation

##
## Omegahat repo
#
#options( repos = "http://www.omegahat.org/R/" )
# Get new modules
#plist <- new.packages(lib.loc = "/home/software/sloan/local/lib/R/3.3")
#sapply(plist,function(x){try(install.packages(x,lib="/home/software/sloan/local/lib/R/3.3"))})
# Get updated modules
#ulist <- old.packages(lib.loc = "/home/software/sloan/local/lib/R/3.3")
#sapply(ulist,function(x){try(install.packages(x,lib="/home/software/sloan/local/lib/R/3.3"))})

# Save any warnings
cat (file="warnings.rinstall")
warnings(file="warnings.rinstall",append=TRUE)

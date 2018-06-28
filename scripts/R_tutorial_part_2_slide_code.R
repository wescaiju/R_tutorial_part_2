# Last updated: 180418
# Author: Wesley Cai
# Purpose: To demonstrate examples from part 2 of YSM R course 

# Set the working directory
setwd("")

# **********************************************************************
# Example 1: Accessing TCGA database through cbioportal
# Hypothesis: GATA3 expression correlates with FOXA1 in breast cancer

## For help go to http://www.cbioportal.org/cgds_r.jsp
## First load cgdsr (install it from CRAN if you haven't done so)
library(cgdsr)

## Create a CGDS object
mycgds <- CGDS("http://www.cbioportal.org/public-portal/")
test(mycgds)

## Get list of cancer studies at server. Check out the data
mycancerstudylist <- getCancerStudies(mycgds)

## Get list of cases. Check out the data
mycancerstudy <- mycancerstudylist[30,1] # or "brca_tcga_pub"
mycaselist <- getCaseLists(mycgds, mycancerstudy)

## Get genetic profiles (e.g. microarray values). Check out the data
mygeneticprofile <- getGeneticProfiles(mycgds, mycancerstudy)

## Fetch microarray data for GATA3 and FOXA1
mydata <- getProfileData(mycgds, genes = c("GATA3", "FOXA1"), caseList = "brca_tcga_pub_all", geneticProfiles = "brca_tcga_pub_mrna")

# Plot the data!
plot(mydata)

## Exercise: How do we determine the pearson correlation coefficient and 
## p-value for GATA3 and FOXA1 expression?
## hint functions: corr.test(), complete.cases()
## hint other: Get rid of NA values in mydata first using complete.cases() and dataframe selection
## mydata[complete.cases(mydata),]

# **********************************************************************
# Example 2: Making pretty plots with ggplot

## First load up ggplot2 (install it from CRAN if you haven't done so)
library(ggplot2)

myplot <- ggplot(mydata, aes(GATA3, FOXA1)) + 
  geom_point() + 
  geom_smooth(method='lm',formula=y~x) +
  theme_bw()
myplot

# **********************************************************************
# Example 3: Getting human homolog of mouse gene

## First load up biomaRt (install it from bioconductor if you haven't done so)
library(biomaRt)

## Select the human and mouse datasets
## If you don't know which mart or dataset to use, list by:
## listMarts()
## listDatasets("ENSEMBL_MART_ENSEMBL")
human <- useMart("ENSEMBL_MART_ENSEMBL", dataset = "hsapiens_gene_ensembl")
mouse <- useMart("ENSEMBL_MART_ENSEMBL", dataset = "mmusculus_gene_ensembl")

## First define gene list
geneList <- c("Gata3", "Tgfb1")
## Now fetch the data from biomart
## If you don't know which attribute or filters to use, list by:
## listAttributes(mouse)
## listFilters(mouse)
dictionary <- getLDS(attributes = c("external_gene_name"), filters = "external_gene_name", values = geneList, mart = mouse,
       attributesL = c("hgnc_symbol"), martL = human)

### Exercise: Can you load dictionary.txt and switch all the gene_symbols from mouse to human?
### hint functions: read.table(), getLDS(), merge()

#------------------------------------------------------------#
# Title:  Invisible functions                                #
# Author: Katie Jeynes-Cupper (katie.jeynescupper@gmail.com) #
# Date:   01.02.23                                           #
#------------------------------------------------------------#

.import_annotations <- function(data){
  x <- utils::read.table(data ,header = FALSE, sep="\t",stringsAsFactors=FALSE,
                         quote="")
  x <- x %>% dplyr::rename(seqID_loci = V1,
                           source_loci = V2,
                           type_loci = V3,
                           start=V4,
                           end = V5,
                           seqID= V9 ,
                           feature_type = V11,
                           feature_start =V12,
                           feature_end = V13,
                           strand = V15,
                           phase = V16,
                           attributes = V17) %>%
    dplyr::select(-c(V6, V7, V8, V10, V14))
  return(x)
}




.remove_mapping_errors <- function(data, controls) {
  class_colnames <- c()
  for (i in colnames(data)){
    if (stringr::str_detect(i, "FPKM_" )){
      class_colnames <- c(class_colnames, i)
    }
  }
  onlyControlFPKM <- base::unique(base::grep(paste(controls,collapse="|"),
                                             class_colnames, value=TRUE))
  x <- c()
  for (j in 1:nrow(data) ){
    if(stats::var(stats::na.omit(as.numeric(
      data[j,onlyControlFPKM], na.rm=T)))> 0 ){
      x <- c(x,j)
    }
  }
  data <- data[-x,]
  return(data)
}


# This is a modified version of the base match function, which instead of
# returning an NA value if it does not work, it returns false.
.match_vec <- function (x, table, nomatch = FALSE) {
  (match(x, table, nomatch))
  }


.DESeq_normalise <- function(data, conditions){
  column.data <- data.frame(conditions=as.factor(conditions))
  base::rownames(column.data) <- base::colnames(data)
  count.data.set <- DESeq2::DESeqDataSetFromMatrix(countData=data,
                                                   colData=column.data,
                                                   design= ~ conditions)
  count.data.set$conditions <- stats::relevel(count.data.set$conditions,
                                              conditions[1])
  out <- DESeq2::estimateSizeFactors(count.data.set)
  return(out)
}


.edgeR_normalise <- function(data, conditions){
  d <- edgeR::DGEList(counts = data, group = factor(group))
  assign('edgeR_count_file', d, envir = .GlobalEnv)
  result <- edgeR::calcNormFactors(d)
  result$samples
  result<- edgeR::estimateDisp(result)
  result$common.dispersion
  return(result)
}



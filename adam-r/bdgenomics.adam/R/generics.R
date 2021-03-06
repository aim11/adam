#
# Licensed to Big Data Genomics (BDG) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The BDG licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

#### ADAM Context operations ####

#' The ADAMContext provides functions on top of a SparkContext for loading genomic data.
#' 
#' @name ADAMContext
NULL

#' @rdname ADAMContext
#' @param ac The ADAMContext.
#' @param filePath The path to load the file from.
#' @param ... additional argument(s).
#' @export
setGeneric("loadAlignments",
           function(ac, filePath, ...) { standardGeneric("loadAlignments") })

#' @rdname ADAMContext
#' @export
setGeneric("loadContigFragments",
           function(ac, filePath) { standardGeneric("loadContigFragments") })

#' @rdname ADAMContext
#' @export
setGeneric("loadFragments",
           function(ac, filePath, ...) { standardGeneric("loadFragments") })

#' @rdname ADAMContext
#' @export
setGeneric("loadFeatures",
           function(ac, filePath, ...) { standardGeneric("loadFeatures") })

#' @rdname ADAMContext
#' @export
setGeneric("loadCoverage",
           function(ac, filePath, ...) { standardGeneric("loadCoverage") })

#' @rdname ADAMContext
#' @export
setGeneric("loadGenotypes",
           function(ac, filePath, ...) { standardGeneric("loadGenotypes") })

#' @rdname ADAMContext
#' @export
setGeneric("loadVariants",
           function(ac, filePath, ...) { standardGeneric("loadVariants") })

#### RDD operations ####

#' The GenomicRDD is the base class that all genomic datatypes extend from in ADAM.
#' 
#' @name GenomicRDD
NULL

#' @rdname GenomicRDD
#' @param cmd The command to run.
#' @param tFormatter The name of the ADAM in-formatter class to use.
#' @param xFormatter The name of the ADAM out-formatter class to use.
#' @param convFn The name of the ADAM GenomicRDD conversion class to
#'   use.
#' @param ... additional argument(s).
#' @return Returns a new RDD where the input from the original RDD has
#'   been piped through a command that runs locally on each executor.
#' @export
setGeneric("pipe",
           function(ardd, cmd, tFormatter, xFormatter, convFn, ...) { standardGeneric("pipe") })

#' @rdname GenomicRDD
#' @export
setGeneric("toDF",
           function(ardd) { standardGeneric("toDF") })

setGeneric("replaceRdd",
           function(ardd, rdd) { standardGeneric("replaceRdd") })

setGeneric("wrapTransformation",
           function(ardd, tFn) { standardGeneric("wrapTransformation") })

#' @rdname GenomicRDD
#' @export
setGeneric("transform",
           function(ardd, tFn) { standardGeneric("transform") })

setGeneric("inferConversionFn",
           function(ardd, destClass) { standardGeneric("inferConversionFn") })

setGeneric("destClassSuffix",
           function(destClass) { standardGeneric("destClassSuffix") })

#' @rdname GenomicRDD
#' @param tFn A function that transforms the underlying RDD as a DataFrame.
#' @param destClass The destination class of this transmutation.
#' @export
setGeneric("transmute",
           function(ardd, tFn, destClass, ...) { standardGeneric("transmute") })

#' @rdname GenomicRDD
#' @export
setGeneric("save",
           function(ardd, filePath, ...) { standardGeneric("save") })

#' @rdname GenomicRDD
#' @export
setGeneric("sort",
           function(ardd) { standardGeneric("sort") })

#' @rdname GenomicRDD
#' @export
setGeneric("sortLexicographically",
           function(ardd) { standardGeneric("sortLexicographically") })

#' Saves this RDD to disk as Parquet.
#'
#' @param ardd The RDD to apply this to.
#' @param filePath Path to save file to.
#'
#' @rdname GenomicRDD
#'
#' @export
setGeneric("saveAsParquet",
           function(ardd, filePath) { standardGeneric("saveAsParquet") })

#### Caching operations ####
#' @rdname GenomicRDD
#' @export
setGeneric("cache",
          function(ardd) { standardGeneric("cache") })

#' @rdname GenomicRDD
#' @export
setGeneric("persist",
          function(ardd, sl) { standardGeneric("persist") })

#' @rdname GenomicRDD
#' @param sl the StorageLevel to persist in.
#' @export
setGeneric("unpersist",
          function(ardd, sl) { standardGeneric("unpersist") })

#### AlignmentRecord operations ####

#' The AlignmentRecordRDD is the class used to manipulate genomic read data.
#' 
#' @name AlignmentRecordRDD
NULL

#' @rdname AlignmentRecordRDD
#' @export
setGeneric("toFragments",
           function(ardd) { standardGeneric("toFragments") })

#' @rdname AlignmentRecordRDD
#' @param ardd The RDD to apply this to.
#' @param ... additional argument(s).
#' @export
setGeneric("toCoverage",
           function(ardd, ...) { standardGeneric("toCoverage") })

#' @rdname AlignmentRecordRDD
#' @param kmerLength The value of _k_ to use for cutting _k_-mers.
#' @export
setGeneric("countKmers",
           function(ardd, kmerLength) { standardGeneric("countKmers") })

#' @rdname AlignmentRecordRDD
#' @param filePath The path to save the file to.
#' @export
setGeneric("saveAsSam",
           function(ardd, filePath, ...) { standardGeneric("saveAsSam") })

#' @rdname AlignmentRecordRDD
#' @export
setGeneric("sortReadsByReferencePosition",
           function(ardd) { standardGeneric("sortReadsByReferencePosition") })

#' @rdname AlignmentRecordRDD
#' @export
setGeneric("sortReadsByReferencePositionAndIndex",
           function(ardd) { standardGeneric("sortReadsByReferencePositionAndIndex") })

#' @rdname AlignmentRecordRDD
#' @export
setGeneric("markDuplicates",
           function(ardd) { standardGeneric("markDuplicates") })

#' @rdname AlignmentRecordRDD
#' @param knownSnps A table of known SNPs to mask valid variants.
#' @param validationStringency The stringency to apply towards validating BQSR.
#' @export
setGeneric("recalibrateBaseQualities",
           function(ardd, knownSnps, validationStringency) {
             standardGeneric("recalibrateBaseQualities")
           })

#' @rdname AlignmentRecordRDD
#' @export
setGeneric("realignIndels",
           function(ardd, ...) { standardGeneric("realignIndels") })

#### Coverage operations ####

#' The CoverageRDD class is used to manipulate read coverage counts.
#' 
#' @name CoverageRDD
NULL

#' @rdname CoverageRDD
#' @param ... additional argument(s).
#' @export
setGeneric("collapse",
           function(ardd, ...) { standardGeneric("collapse") })

#' @rdname CoverageRDD
#' @export
setGeneric("toFeatures",
           function(ardd) { standardGeneric("toFeatures") })

#' @rdname CoverageRDD
#' @export
setGeneric("coverage",
           function(ardd, ...) { standardGeneric("coverage") })

#' @rdname CoverageRDD
#' @export
#' @aliases aggregatedCoverage,CoverageRDD-method
setGeneric("aggregatedCoverage",
           function(ardd, ...) { standardGeneric("aggregatedCoverage") })

#' @rdname CoverageRDD
#' @export
setGeneric("flatten",
           function(ardd) { standardGeneric("flatten") })

#### Fragment operations ####

#' The FragmentRDD class is used to manipulate paired reads.
#' 
#' @name FragmentRDD
NULL

#' @rdname FragmentRDD
#' @param ardd The RDD to apply this to.
#' @export
setGeneric("toReads",
           function(ardd) { standardGeneric("toReads") })

#### Genotype and Variant operations ####

#' Converts this RDD to VariantContexts.
#'
#' @param ardd The RDD to apply this to.
#' @return Returns this RDD of Variants as VariantContexts.
#' @export
setGeneric("toVariantContexts",
           function(ardd) { standardGeneric("toVariantContexts") })


#' Converts this RDD to Variants.
#'
#' @param ardd The RDD to apply this to.
#' @return Returns this RDD of Genotypes as Variants.
#' @export
setGeneric("toVariants",
           function(ardd, ...) { standardGeneric("toVariants") })

#### NucleotideContigFragment operations ####

#' The NucleotideContigFragmentRDD class is used to manipulate contigs.
#' 
#' @name NucleotideContigFragmentRDD
NULL

#' @rdname NucleotideContigFragmentRDD
#' @param ardd The RDD to apply this to.
#' @param flankLength The length to extend adjacent records by.
#' @export
setGeneric("flankAdjacentFragments",
           function(ardd, flankLength) {
             standardGeneric("flankAdjacentFragments")
           })

#### Variant operations ####

#' The VariantContextRDD class is used to manipulate VCF-styled data.
#'
#' Each element in a VariantContext RDD corresponds to a VCF line. This
#' differs from the GenotypeRDD, where each element represents the genotype
#' of a single sample at a single site, or a VariantRDD, which represents
#' just the variant of interest.
#' 
#' @name VariantContextRDD
NULL

#' @rdname VariantContextRDD
#' @param ardd The RDD to apply this to.
#' @param filePath Path to save VCF to.
#' @param ... additional argument(s).
#' @export
setGeneric("saveAsVcf",
           function(ardd, filePath, ...) { standardGeneric("saveAsVcf") })

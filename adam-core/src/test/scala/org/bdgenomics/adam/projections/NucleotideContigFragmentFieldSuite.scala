/**
 * Licensed to Big Data Genomics (BDG) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The BDG licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
package org.bdgenomics.adam.projections

import org.apache.spark.rdd.RDD
import org.bdgenomics.adam.projections.NucleotideContigFragmentField._
import org.bdgenomics.adam.rdd.ADAMContext._
import org.bdgenomics.adam.rdd.TestSaveArgs
import org.bdgenomics.adam.util.ADAMFunSuite
import org.bdgenomics.formats.avro.{ Contig, NucleotideContigFragment }

class NucleotideContigFragmentFieldSuite extends ADAMFunSuite {

  sparkTest("Use projection when reading parquet nucleotide contig fragments") {
    val path = tmpFile("nucleotideContigFragments.parquet")
    val rdd = sc.parallelize(Seq(NucleotideContigFragment.newBuilder()
      .setContigName("6")
      .setDescription("Chromosome 6")
      .setSequence("ACTG")
      .setIndex(1)
      .setStart(0)
      .setEnd(4)
      .setLength(4)
      .setFragments(4)
      .build()))
    rdd.saveAsParquet(TestSaveArgs(path))

    val projection = Projection(
      contigName,
      description,
      sequence,
      index,
      start,
      end,
      length,
      fragments
    )

    val nucleotideContigFragments: RDD[NucleotideContigFragment] = sc.loadParquet(path, optProjection = Some(projection))
    assert(nucleotideContigFragments.count() === 1)
    assert(nucleotideContigFragments.first.getContigName === "6")
    assert(nucleotideContigFragments.first.getDescription === "Chromosome 6")
    assert(nucleotideContigFragments.first.getSequence === "ACTG")
    assert(nucleotideContigFragments.first.getIndex === 1)
    assert(nucleotideContigFragments.first.getStart === 0)
    assert(nucleotideContigFragments.first.getEnd === 4)
    assert(nucleotideContigFragments.first.getLength === 4)
    assert(nucleotideContigFragments.first.getFragments === 4)
  }
}

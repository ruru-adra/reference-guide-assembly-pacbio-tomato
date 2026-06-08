#!/bin/bash
nohup singularity exec --cleanenv \
-B /data2:/data2 \
/home/biotech/bioinfo_sware/singularity-ce-4.1.0/deepvariant_1.6.1.sif \
/opt/deepvariant/bin/run_deepvariant \
--model_type=PACBIO \
--ref=/data2/tomato/ref_genome/MbTMV_clean.fa \
--reads=/data2/tomato/CKH_aln.bam \
--output_vcf=/data2/tomato/CKH.vcf.gz \
--output_gvcf=/data2/tomato/CKH.g.vcf.gz \
--num_shards=16

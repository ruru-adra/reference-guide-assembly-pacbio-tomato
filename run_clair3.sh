#!/bin/bash

nohup singularity exec --cleanenv \
-B /data2:/data2 \
-B /home/biotech/bioinfo_sware:/bioinfo_sware \
-B /data2/tomato/tmp:/tmp \
--env TMPDIR=/data2/tomato/tmp \
/home/biotech/bioinfo_sware/singularity-ce-4.1.0/clair3_latest.sif \
/opt/bin/run_clair3.sh \
--bam_fn=/data2/tomato/CKH_aln.bam \
--ref_fn=/data2/tomato/ref_genome/MbTMV_clean.fa \
--threads=10 \
--platform="hifi" \
--model_path=/bioinfo_sware/Clair3/models/hifi_revio \
--output=/data2/tomato/clair3_call/clair3_CKH \
--include_all_ctgs \
--gvcf

#!/bin/bash
#singularity exec --cleanenv -B /data2:/data2 /home/biotech/bioinfo_sware/singularity-ce-4.1.0/ngmlr_latest.sif ngmlr -t 10 -r /data2/tomato/ref_genome/MbTMV_clean.fa -q /data2/tomato/MT-3.fastq.gz -x pacbio -o /data2/tomato/ngmlr_rslt/MT3_ngmlr.sam;
singularity exec --cleanenv -B /data2:/data2 /home/biotech/bioinfo_sware/singularity-ce-4.1.0/ngmlr_latest.sif ngmlr -t 10 -r /data2/tomato/ref_genome/MbTMV_clean.fa -q /data2/tomato/Chakra.fastq.gz -x pacbio -o /data2/tomato/ngmlr_rslt/CKH_ngmlr.sam

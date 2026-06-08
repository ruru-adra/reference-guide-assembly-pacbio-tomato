#!/bin/bash
set -euo pipefail

# Heinz SL3.0 / ITAG3.0 paths
REF_FASTA=/data2/tomato/ref_genome/heinz/clean_heinz.fa
REF_GFF=/data2/tomato/ref_genome/heinz/heinz_chr.gff3
TARGET=/data2/tomato/ragtag/heinz/scaffold/mt1_heinz_scaff_clean.fasta
WORKDIR=/data2/tomato/ragtag/heinz
THREADS=20

cd $WORKDIR

# Sanity check
echo "=== Input check ==="
ls -lh $REF_FASTA $REF_GFF $TARGET
echo "Reference genes: $(grep -c -P '\tgene\t' $REF_GFF)"
echo ""

# Run Liftoff
echo "=== Running Liftoff (Heinz ITAG3.0 -> MT1) ==="
liftoff \
    -g $REF_GFF \
    -o MT1_heinz_lifted.gff3 \
    -u MT1_heinz_unmapped_features.txt \
    -dir liftoff_heinz_intermediate \
    -p $THREADS \
    $TARGET \
    $REF_FASTA

echo ""
echo "=== Done ==="
echo "Lifted genes: $(grep -c -P '\tgene\t' MT1_heinz_lifted.gff3)"
echo "Unmapped features: $(wc -l < MT1_heinz_unmapped_features.txt)"

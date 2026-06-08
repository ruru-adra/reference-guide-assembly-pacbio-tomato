#!/bin/bash
set -euo pipefail

# File locations — Heinz SL3.0 run
REF=/data2/tomato/ref_genome/heinz/clean_heinz.fa
QUERY=/data2/tomato/ragtag/assembly.fasta
WORKDIR=/data2/tomato/ragtag/heinz
THREADS=20

cd $WORKDIR

# Sanity check inputs
echo "=== Input check ==="
ls -lh $REF $QUERY
echo "Reference sequences: $(grep -c '^>' $REF)"
echo "Query contigs: $(grep -c '^>' $QUERY)"
echo ""

# Scaffold
echo "=== Running RagTag scaffold (Heinz SL3.0) ==="
ragtag.py scaffold \
    $REF \
    $QUERY \
    -o scaffold \
    -t $THREADS \
    --aligner minimap2 \
    --mm2-params '-x asm5' \
    -r -g 100 \
    -u

samtools faidx scaffold/ragtag.scaffold.fasta

echo ""
echo "=== Top 15 scaffolds ==="
sort -k2 -nr scaffold/ragtag.scaffold.fasta.fai | head -15 | \
    awk '{printf "%-30s %12.2f Mbp\n", $1, $2/1e6}'

echo ""
echo "=== Size distribution ==="
awk '{if($2>=10e6)big++; else if($2>=1e6)med++; else small++}
     END{printf "  >=10 Mbp: %d\n  1-10 Mbp: %d\n  <1 Mbp: %d\n", big+0, med+0, small+0}' \
    scaffold/ragtag.scaffold.fasta.fai

echo ""
echo "=== Total size ==="
awk '{s+=$2} END {printf "Total: %.2f Mbp across %d scaffolds\n", s/1e6, NR}' \
    scaffold/ragtag.scaffold.fasta.fai

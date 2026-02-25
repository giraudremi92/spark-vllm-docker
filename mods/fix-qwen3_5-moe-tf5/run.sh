#!/bin/bash
# Fix incompatibility between vLLM's qwen3_5_moe config and transformers 5:
# ignore_keys_at_rope_validation is a list but transformers 5 uses | operator (set union)
set -e

FILE="/usr/local/lib/python3.12/dist-packages/transformers/modeling_rope_utils.py"

echo "Patching $FILE..."
sed -i 's/ignore_keys_at_rope_validation = ignore_keys_at_rope_validation | {/ignore_keys_at_rope_validation = set(ignore_keys_at_rope_validation) | {/g' "$FILE"
echo "Patch applied."

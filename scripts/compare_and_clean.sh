#!/bin/bash

# Array of directory pairs: "source_dir target_dir file_extension"
DIR_PAIRS=(
    "../.claude/agents/instructions ../common/instructions md"
    "../.claude/agents/personas ../common/personas md"
    "../.github/instructions ../common/instructions md"
    "../.github/personas ../common/personas md"
    "../.github/copilot/chatmodes ../templates/copilot/copilot/chatmodes md"
)

for pair in "${DIR_PAIRS[@]}"; do
    set -- $pair
    SRC_DIR="$1"
    TARGET_DIR="$2"
    EXT="$3"

    echo "Comparing $SRC_DIR to $TARGET_DIR for *.$EXT files..."
    for src_file in $(find "$SRC_DIR" -type f -name "*.$EXT"); do
        # Generate target file path by replacing SRC_DIR with TARGET_DIR in src_file path
        target_file="${src_file/$SRC_DIR/$TARGET_DIR}"

        if [[ -f "$target_file" ]]; then
            if cmp -s "$src_file" "$target_file"; then
                echo "Identical: ${src_file} - removing $src_file"
                rm "$src_file"
            else
                echo "Different: ${src_file}"
            fi
        else
            echo "Target missing for: ${src_file}"
        fi
    done

    # Remove any empty folders under SRC_DIR
    find "$SRC_DIR" -type d -empty -delete

    echo ""
done

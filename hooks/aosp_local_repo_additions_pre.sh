#!/usr/bin/env bash

# pin to specific versions if they have been specified
if [ -n "${LOCAL_MANIFEST_REVISIONS}" ]; then
    update_local_manifest_revisions_script="${CORE_DIR}/scripts/update_local_manifest_revisions.py"
    if [ -f "${update_local_manifest_revisions_script}" ]; then
        log "Updating local manifests with specified revisions ${LOCAL_MANIFEST_REVISIONS}"
        python3 "${update_local_manifest_revisions_script}" "${CORE_DIR}/local_manifests/*.xml" "${LOCAL_MANIFEST_REVISIONS}"
    fi
fi

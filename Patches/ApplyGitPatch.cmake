# Usage: cmake -DPATCH_FILE=<file> -P ApplyGitPatch.cmake   (run inside the source dir)
# Idempotent: skips if the patch is already applied.
execute_process(COMMAND git apply --reverse --check --ignore-whitespace "${PATCH_FILE}"
                RESULT_VARIABLE already_applied OUTPUT_QUIET ERROR_QUIET)
if(already_applied EQUAL 0)
  message(STATUS "Patch already applied: ${PATCH_FILE}")
  return()
endif()
execute_process(COMMAND git apply --ignore-whitespace "${PATCH_FILE}" RESULT_VARIABLE res)
if(NOT res EQUAL 0)
  message(FATAL_ERROR "Failed to apply patch: ${PATCH_FILE}")
endif()
message(STATUS "Applied patch: ${PATCH_FILE}")

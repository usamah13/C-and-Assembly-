#
# This is the solution to CPSC 213 Assignment 7.
# Do not share this code or any portion of it with anyone in any way.
# Do not remove this comment.
#

  gpc $2, r0        # get the address of the .long block in r0
  br next           # jump over the data
  .long 0x2f62696e
  .long 0x2f7368ae
next:
  ld $7, r1         # load size of command
  sys $2            # system call: exec
  halt

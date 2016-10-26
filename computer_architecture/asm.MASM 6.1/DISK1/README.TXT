
                               README.DOC File

             Release Notes for the Microsoft(R) Macro Assembler
                Professional Development System, Version 6.1

     (C) Copyright 1992, Microsoft Corporation.  All rights reserved.
                                          
     This document contains release notes for version 6.1 of the
     Microsoft Macro Assembler Professional Development System for
     MS-DOS(R).  The information in this document and in the Microsoft 
     Advisor (online help) is more up-to-date than that in the manuals.
  
     Microsoft improves its languages documentation at the time of
     reprinting, so some of the information in this file may already be
     included in your manuals.



==============================< Contents >================================

     This file has 4 parts:
  
               Part     Contents
               ----     --------
               1        Documentation Errata

               2        Information on Microsoft CodeView

               3        Tips for Using MASM 6.1

               4        Known Assembler Bugs



====================< Part 1: Documentation Errata >======================


     Reference, Page 98: LEA is no longer optimized
     -------------------------------------------------
     The MASM 6.1 Reference indicates that the LEA instruction is
     encoded as a MOV when the source operand is a direct memory address.

     In response to programmer requests, MASM 6.1 no longer performs this 
     optimization automatically.  The optimization can be performed by 
     using the OPATTR operator, as shown in the following macro:

          MOVLEA MACRO Dest, Symbol
          IF (OPATTR(Symbol)) AND 08h
               MOV Dest, OFFSET Symbol
          ELSE
               LEA Dest, Symbol
          ENDIF
          ENDM


     Programmer's Guide, Page 202: User-Defined Epilogues & Prologues
     --------------------------------------------------------------------
     The documentation for user-defined epilogue and prologue code reads
     "Your macro function must return the parmbytes parameter."  It
     should read "...the localbytes parameter."


     Help for Runtime Error R6921
     ---------------------------------------
     The online help for runtime error R6921 reads "...Possibly the
     CONFIG.SYS file contained a line such as DEVICE=C:\OS\MM386.EXE..."
     The file name should read "C:\DOS\EMM386.EXE".


===============< Part 2: Information on Microsoft CodeView >==============

     CV.TXT File
     --------------------
     Detailed information on configuring CodeView is in the CV.TXT file,
     in the directory into which you installed MASM.


     CodeView and 32-bit Registers
     --------------------------------------------------
     CodeView 4.01 does not support single-stepping through code which
     uses 32-bit registers while a DPMI server is present.  Windows 3.1
     and 386-MAX are examples of DPMI servers.  If you need to single-
     step through 32-bit code, you can exit Windows and use a VCPI server 
     such as EMM386.EXE to run CodeView, or use an alternate debugger 
     such as WDEB386 (available in the Microsoft Windows Software 
     Development Kit).
     

     CodeView and .COM Files
     --------------------------------------------------
     CodeView 4.01 does not show source code when debugging .COM files.  
     If you need to view source code, build your program as a small-model 
     .EXE for debugging purposes.


====================< Part 3: Tips for Using MASM 6.1 >===================

     Working with MASM 5.1 Code
     -------------------------------------
     There are differences between MASM 5.1 and MASM 6.1.  Some code
     written for MASM 5.1 will not assemble correctly with MASM 6.1.
     Appendix A of the MASM Programmer's Guide discusses how to work
     with code written for MASM 5.1.


     SAMPLES.TXT File
     ---------------------------------------------
     The file SAMPLES.TXT is installed if you choose to install the
     sample code during the setup process.  SAMPLES.TXT contains
     information about the purpose of the samples, and about additional
     tools you may need to build some of the samples.


     ERRMSG.TXT File
     ---------------------------------------------
     The file ERRMSG.TXT is installed in the directory in which you
     installed MASM.  This file contains information about error
     messages which are not documented in the Programmer's Guide or
     the MASM help files.


     NMAKE and NMAKER
     --------------------
     MASM 6.1 includes two versions of the NMAKE project management 
     utility.  NMAKER.EXE is a real-mode version of the utility.  
     NMAKE.EXE is a driver program which first loads the MS-DOS extender 
     into memory, and then runs NMAKER.EXE.  Using the NMAKE.EXE driver 
     will result in faster build times.  Some development tools from 
     other manufacturers may be incompatible with NMAKE.EXE.  If you 
     encounter incompatibilities, use NMAKER.EXE instead.


     Working With Microsoft BASIC Far Strings
     ---------------------------------------------
     The BASIC runtime function StringAssign does not correctly handle
     strings of zero length.  Instead of calling StringAssign to convert
     a zero-length string, simply return a near pointer to a doubleword 
     with the value 0.


     Using Control-C to Halt Operation of MASM
     -----------------------------------------------
     MS-DOS applications running under DPMI, such as ML.EXE, may not 
     respond immediately to pressing Control-C.  If you press Control-C, 
     and ^C appears on the screen but you are not returned to MS-DOS, 
     press the Enter key.


     Assembling Files Generated by Compilers
     ------------------------------------------
     Many compilers support assembly-language output.  If you experience
     difficulty assembling the output of such compilers, you may need to
     assemble using the /Zm option.  In some cases (for instance, if the
     compiler inserts nondelimited comments or page numbers) it may be 
     necessary to edit the assembly-language output by hand.


     Using MASM 6.x Structures
     --------------------------------------------
     MASM 6.0 and 6.1 support a more powerful syntax for structure
     definition and usage than previous versions of MASM.  This more
     powerful syntax is enabled by default.  To use the older syntax,
     issue the OPTION OLDSTRUCTS directive (see Appendix A of the MASM
     Programmer's Guide for more information).

     Note: use of nested structures requires the new MASM 6.x syntax.
     If you use nested structures, the OPTION OLDSTRUCTS directive will
     be ignored for the structure which is nested.


     Differences Between MASM 6.0 and MASM 6.1
     --------------------------------------------
     MASM 6.1 uses a different encoding for the CMP <reg8>,<reg8> 
     instruction than MASM 6.0 did.  There is no difference in length or 
     processor timing.
     
     
======================< Part 4: Known Assembler Bugs >====================

     Exiting from MS-DOS Critical Errors
     --------------------------------------------------
     MS-DOS critical errors, such as attempting to assemble a file on
     a drive which does not exist or is empty, produce the "Abort, Retry
     or Fail?" error message.  Selecting "Abort" when running MASM in 
     MS-DOS may cause memory to be corrupted.  This problem does not 
     occur when running MASM in Windows.  To avoid this problem, select
     "Retry" or "Fail", as appropriate.


     Expression Order in High-Level Conditionals
     --------------------------------------------------
     Comparisons in high-level conditionals cannot begin with a literal.
     For instance, this comparison causes an error:

          .IF 1 == AX

     but this works properly:

          .IF AX == 1


     Initializing Nested Structures
     --------------------------------------------------
     If one structure is nested within another, the inner structure's
     initializer list must either be empty or include a comma between
     every field.  For example, the structure INFO declared on page 123 
     of the Programmer's Guide contains a structure of type DISKDRIVES,
     which in turn contains three BYTE fields.  An object of type INFO
     could be initialized as:

          Info1 INFO { , , , , { }}      ; Inner initializer list is blank

     or as:

          Info1 INFO { , , , , {1, 2, }} ; Commas for all three fields

     but not as:

          Info1 INFO { , , , , {1, 2 }}  ; Error: missing last comma


     Span-Dependent Expressions used in Macros
     --------------------------------------------------
     MASM 6.1 evaluates macro expressions only on the first pass of 
     assembly, but code and data are reevaluated on subsequent passes.
     Because of this, macro expressions which depend on the span between
     two addresses may not evaluate correctly.  For instance, the
     following code will not evaluate correctly:

          Label1:
               JMP Label2
          Label2:

          REPEAT Label2 - Label1  ; Evaluates incorrectly
               INC AX
          ENDM

     View the listing file to determine if a questionable macro expression
     was evaluated as desired.


     Span-Dependent Equates in Macros and EXTERNDEF ABS
     ---------------------------------------------------
     The ABS operator causes an identifier to be exported as a relocatable
     unsized constant (see Programmer's Guide page 220).  If ABS is used
     with EXTERNDEF within a macro, and the constant being exported
     depends on the difference between two addresses, the constant may not
     be exported correctly.  In some cases, the listing file will show the
     correct value, but the value in the resulting .obj will be incorrect.
     For instance, the following code will not evaluate correctly:

          EXTERNDEF TableSize:ABS  ; Will not be exported correctly

          MAKETABLE MACRO
          Table1 LABEL BYTE
               DB 0, 1, 2
          TableSize EQU $-Table1
          ENDM

          SEG1 SEGMENT
          MAKETABLE
          SEG1 ENDS

     To avoid this problem, either use the 'PUBLIC' directive in place of 
     'EXTERNDEF', or put a label before the equate, within the macro.


     Span-Dependent Text Equates
     --------------------------------------------------
     The TEXTEQU operator is evaluated on the first assembly pass.  If
     TEXTEQU is used with an expression that depends on the difference
     between two addresses, the resulting constant may be incorrect.
     For instance, the following code will not evaluate correctly:

          Label1:
               JMP Label2
          Label2:
          WrongNum TEXTEQU %Label2-Label1 ; WrongNum will be incorrect


     Using The /link /nologo Command Line Options
     ---------------------------------------------------------
     The /link command line option for ML causes all following parameters
     to be passed to the linker.  If the /nologo command line option for
     is passed to the linker, the linker may parse other parameters
     incorrectly.  To avoid this problem, use the /nologo command line 
     switch for ML rather than passing it to the linker.  For instance,
     replace:

          ML hello.asm /link /nologo MYLIB.LIB

     with:

          ML /nologo hello.asm /link MYLIB.LIB

     Alternately, you may use the NMAKE utility to automate building
     your project.


     RET n Does Not Generate Epilogue
     ---------------------------------------------------------
     In MASM 5.1, using RET followed by a constant would cause epilogue
     code to be generated.  MASM 6.1 does not generate epilogue code in
     this case.

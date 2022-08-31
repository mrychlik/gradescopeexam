A LaTeX document class for preparing tests and homework for Gradescope
======================================================================

How to use?
===========

If you are a user of exam.cls from LaTeX distribution, the format will be familiar to you.
There is no 100% compatibility, but overall structure of the file is similar.

Many of the bells and whistles of exam.cls are not implemented, but the problems
work the same.

What is new?
============

- The solution box for writing proofs (prooforbox) was added for advanced math exams.

Output modes
============

- The blank exam shoul use option '\noprintanswers'.
- To publish just the solution key (marked up multiple choice questions and numerical answers)
  use the option '\printsolutionkey'
- To publish full solutions use the option '\printanswers'

For students preparing solutions from templates in LaTeX form provided by the instructor
========================================================================================

- You should make sure that your solutions are contained in the boxes in the blank exam.
- If your solution is too long to fit, you should make sure not to insert an extra page
  before the next problem. Rather, you may add a page past the last page of the exam
  and refer the grader to that page (e.g. by page number) in your "boxed" portion of the solution.
- To mark up automatically multiple choice problems, change the word '\choice' to '\CorrectChoice'
- Use the '\printanswers' option to produce a version ready for Gradescope submission.
- You may need to force page breaks by using '\newpage' to match the page count with the blank exam.


Enjoy,
--Marek Rychlik

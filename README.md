Recommenders List Generator for LaTeX
-------------------------------------

This tool generates a list of people for whom recommendation letters were written. It then creates a LaTeX file that can be included in the curriculum vitae (CV) for example, and it also creates a table (.CSV file) with the results.

The code assumes that all recommendation letters are kept in a folder with sub-folders. The sub-folder names should be the people's names with lastname - underscore - firstname convention.

## Installation

Clone and install the package. Modify the path in `myConfig.R`

## Generation

First run **make.recommendation.letter.list.R**, it will generated the generated files.

Compile the **CV-Recommendation-Letters-Preview.tex** to generate a preview of the output.

# Using unoconv
Assuming in the same folder as the documents to be converted
### docx -> pdf
    for i in *.docx; do unoconv -f pdf "$i"; done
### pptx -> pdf
    for i in *.pptx; do unoconv -f pdf "$i"; done
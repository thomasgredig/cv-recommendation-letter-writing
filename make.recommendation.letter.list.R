#########################
#
# make a list of students
# and years for whom
# letters of recommendations
# were sent
#
# Run this code to generate
# the gneerated-Recommendation-Letter.tex
# file, then compile the TEX file
#
#########################

path.source = '..'
source('myConfig.R')  # to overwrite path

d = dir(path.source, pattern='^.+_.+$')
print(paste("Found ",length(d), " students."))

r = data.frame()
for(student.dir in d) {
  fdir = file.path(path.source, student.dir)
  # go into directory and find oldest file
  file.list = dir(fdir)
  ct0=0
  for(f in file.list) {
    fname = file.path(fdir, f)
    ct = file.info(fname)$mtime
    #print(ct)
    if (ct<ct0) {ct0 = ct}
  }
  # number of recommendations:
  noRec = length(which(grepl('ecommendation',file.list)==TRUE)) +
    length(which(grepl('etter',file.list)==TRUE))
  print(paste(fdir,':',ct,':',noRec))
  name <- strsplit(student.dir,'_')[[1]]
  r = rbind(r, data.frame(
    yr = substr(ct,1,4),
    last.name = name[1],
    first.name = name[2],
    num.Recommendations = noRec,
    num.Documents = length(file.list),
    date = ct
  ))
}

#  sort by year
r = r[order(r$date),]
str(r)
r$last.name = as.character(levels(r$last.name)[r$last.name])
r$first.name = as.character(levels(r$first.name)[r$first.name])

# save data
write.csv(r, file=file.path(path.source,'_results-generated',
                            'make.recommendation.letter.list.csv'))

# output a list that can be used in a LaTeX document
yr0 = 0
t = c()
for(i in 1:nrow(r)) {
  if (r$yr[i] != yr0) {
    yr0 = r$yr[i]
    t = c(t, paste0("\n \\textbf{", yr0,":}\n"))
  }
  t=c(t, paste(r$first.name[i], ' ',r$last.name[i],'; ',sep=''))
}


fileConn<-file(file.path(path.source,'_results-generated',
                         "make.recommendation.letter.list.tex"))
writeLines(c("\\section{Recommendation Letters}",
             paste0("List of ", nrow(r) ," Recommendees: \n")), 
             fileConn)
writeLines(t, fileConn)
close(fileConn)

fileConn<-file("make-recommendation-letter-list.tex")
writeLines(c("\\section{Recommendation Letters}",
             paste0("List of ", nrow(r) ," Recommendees: \n")), 
           fileConn)
writeLines(t, fileConn)
close(fileConn)


set title "%%FILE%%"
set xlabel ""
set ylabel "time(s)"
set yrange [0:*]
set style data histogram

plot "%%FILE%%" using (0):1 with points title "Str",\
     "%%FILE%%" using (1):2 with points title "Regexp",\
     "%%FILE%%" using (2):3 with points title "Regexp (w/ string parsing)",\
     "%%FILE%%" using (3):4 with points title "Pcre",\
     "%%FILE%%" using (4):5 with points title "Pcre (w/o grouping)",\
     "%%FILE%%" using (5):6 with points title "Re",\
     "%%FILE%%" using (6):7 with points title "Re (w/ string parsing)"

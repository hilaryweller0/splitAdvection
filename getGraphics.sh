#!/bin/bash -e

# Root directory where graphics files can be found
ROOTDIR=/home/hilary/OpenFOAM/*/run

#List of files to convert to png
pngFiles=(
deformingAdvection/orthogonal_c1/1920x960/0/T.pdf
deformingAdvection/orthogonal_c1/1920x960/1/T.pdf
deformingAdvection/orthogonal_c1/1920x960/2/T.pdf
deformingAdvection/orthogonal_c1/1920x960/3/T.pdf
deformingAdvection/orthogonal_c1/1920x960/4/T.pdf
deformingAdvection/orthogonal_c1/1920x960/5/T.pdf
)

# List of files to copy and rename
cpFiles=(
deformingAdvection/nonOrthogW_c1/120x60/0/Tmesh.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt1000CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt100CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt200CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt25CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt500CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt50CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_coarse/save/cubicUpwindCPCFit_dt50CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_fine/save/cubicUpwindCPCFit_dt12.5CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_vfine/save/cubicUpwindCPCFit_dt6.25CN_up/10000/Tall.pdf

vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt1000N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt100N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt200N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt25N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt500N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography/save/cubicUpwindCPCFit_dt50N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography_coarse/save/cubicUpwindCPCFit_dt50N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography_fine/save/cubicUpwindCPCFit_dt12.5N_up/10000/TallTall.pdf
vSlice/horizontalAdvection/highOrography_vfine/save/cubicUpwindCPCFit_dt6.25N_up/10000/TallTall.pdf

solidBodyRotationOnPlane/l2errors.eps
solidBodyRotationOnPlane/linferrors.eps
solidBodyRotationOnPlane/orthogonal/100x100/dt_1/Tcontours.pdf
solidBodyRotationOnPlane/nonOrthog/100x100/dt_1/Tcontours.pdf
solidBodyRotationOnPlane/orthogonal/100x100/dt_10/TcontoursBig.pdf
solidBodyRotationOnPlane/nonOrthog/100x100/dt_10/TcontoursBig.pdf
solidBodyRotationOnPlane/orthogonal/400x400/dt_2.5/Tcontours.pdf
solidBodyRotationOnPlane/nonOrthog/400x400/dt_2.5/Tcontours.pdf
solidBodyRotationOnPlane/legends/Tdiff.eps
solidBodyRotationOnPlane/legends/TdiffBig_Tdiff.eps
solidBodyRotationOnPlane/nonOrthog/50x50/analytic/constant/mesh.pdf
solidBodyRotationOnPlane/nonOrthog/50x50/analytic/0/UT.pdf
)

# List of files to convert from eps format to pdf
epsFiles=(
deformingAdvection/plots/l2errors_c1.eps
deformingAdvection/plots/linferrors_c1.eps
deformingAdvection/plots/l2errors_c10.eps
deformingAdvection/plots/linferrors_c10.eps
deformingAdvection/plots/l2errors_dt.eps
deformingAdvection/plots/linferrors_dt.eps
deformingAdvection/legends/Tmesh_T.eps
deformingAdvection/legends/T.eps
vSlice/horizontalAdvection/orography/legends/Tall_TdiffAll.eps
)

# Copy and rename the cpFiles
for file in ${cpFiles[*]}
do
    fileNew=`echo $file | sed 's/\//_/g'`
    fileNew=HilarysGraphics/$fileNew
    #echo $fileNew
    rsync -utv $ROOTDIR/$file $fileNew
done

# Convert and rename the files from pdf to png
for file in ${pngFiles[*]}
do
    fileNew=`echo $file | sed 's/\//_/g' | sed 's/\./p/g' | sed 's/ppdf//g'`
    fileNew=HilarysGraphics/$fileNew.png
    pngFile=`echo $ROOTDIR/$file | sed 's/.pdf/.png/g'`
    
    if [ ! -e $pngFile ] || [ `stat -c "%Y" $ROOTDIR/$file` -gt `stat -c "%Y" $pngFile` ]
      then
        echo converting $ROOTDIR/$file to $pngFile
        echo quit | gs -sDEVICE=pngalpha -sPAPERSIZE=a2 -r144 -q -dNOPAUSE -sOutputFile=%stdout% -- $ROOTDIR/$file | \
             convert -trim - $pngFile
    fi

    rsync -ut $pngFile $fileNew
done

# Convert and rename the eps files
for file in ${epsFiles[*]}
do
    fileNew=`echo $file | sed 's/\//_/g' | sed 's/\./p/g' | sed 's/peps//g'`
    fileNew=HilarysGraphics/$fileNew.pdf
    pdfFile=`echo $ROOTDIR/$file | sed 's/.eps/.pdf/g'`
    
    if [ ! -e $pdfFile ] || [ `stat -c "%Y" $ROOTDIR/$file` -gt `stat -c "%Y" $pdfFile` ]
      then
        echo converting $ROOTDIR/$file to $pdfFile
        makebb $ROOTDIR/$file
        epstopdf $ROOTDIR/$file
    fi

    rsync -ut $pdfFile $fileNew
done


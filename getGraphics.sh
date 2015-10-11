#!/bin/bash -e

# Root directory where graphics files can be found
ROOTDIR=/home/hilary/OpenFOAM/hilary-2.3.0/run

# List of files to copy and rename
cpFiles=(
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt1000CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt100CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt200CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt25CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt500CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography/save/cubicUpwindCPCFit_dt50CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_coarse/save/cubicUpwindCPCFit_dt50CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_fine/save/cubicUpwindCPCFit_dt12.5CN_up/10000/Tall.pdf
vSlice/horizontalAdvection/orography_vfine/save/cubicUpwindCPCFit_dt6.25CN_up/10000/Tall.pdf
)

# List of files to convert from eps format to pdf
epsFiles=(vSlice/horizontalAdvection/orography/legends/Tall_TdiffAll.eps)

# Copy and rename the cpFiles
for file in ${cpFiles[*]}
do
    fileNew=`echo $file | sed 's/\//_/g'`
    fileNew=HilarysGraphics/$fileNew
    echo $fileNew
    rsync -ut $ROOTDIR/$file $fileNew
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


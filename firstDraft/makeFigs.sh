#!/bin/bash -e
cd figures

for file in stencil sbrc1 sbrc10 sbr_dx sbr_dt overMountains overMountains_dx deform_init deform deform_dx deform_dt; do
    fileR=`filename -r $file`
    lyx --export pdflatex -f $fileR
    pdflatex $fileR
    pdfcrop $fileR.pdf ../$fileR.pdf
    evince ../$fileR.pdf &
done

cd ..

cp -u HilarysGraphics/solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf .

eps2png2 deform.pdf
eps2png2 sbrc10.pdf
eps2png2 sbrc1.pdf

zip figures.zip stencil.pdf solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf sbrc1.png sbrc10.png sbr_dx.pdf sbr_dt.pdf overMountains.png overMountains_dx.pdf deform_init.pdf deform.png deform_dx.pdf deform_dt.pdf


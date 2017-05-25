#!/bin/bash -e
cd makeFigs

for file in stencils sbrc1 sbrc10 sbr_dx sbr_dt overMountains overMountains_dx deform_init deform deform_dx deform_dt; do
    echo $file
    lyx --export pdflatex -f $file
    pdflatex $file
    pdfcrop $file.pdf ../figures/$file.pdf
    rm $file.pdf
    gv ../figures/$file.pdf &
done

cd ..

cp -u HilarysGraphics/solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf figures

eps2png figures/deform.pdf
eps2png figures/sbrc10.pdf
eps2png figures/sbrc1.pdf
eps2png figures/overMountains.pdf

rm figures/deform.pdf figures/sbrc10.pdf figures/sbrc1.pdf figures/overMountains.pdf

#zip figures.zip stencil.pdf solidBodyRotationOnPlane_nonOrthog_50x50_analytic_constant_mesh.pdf sbrc1.png sbrc10.png sbr_dx.pdf sbr_dt.pdf overMountains.png overMountains_dx.pdf deform_init.pdf deform.png deform_dx.pdf deform_dt.pdf


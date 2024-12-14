NVCC        = nvcc
LD_FLAGS    = -lcudart
NVCC_FLAGS  = -O3 --std=c++17

EXE         = sgemm-tiled
OBJ         = main.obj support.obj

default: $(EXE)

main.obj: main.cu kernel.cu support.h
	$(NVCC) -c -o $@ main.cu $(NVCC_FLAGS)

support.obj: support.cu support.h
	$(NVCC) -c -o $@ support.cu $(NVCC_FLAGS)

$(EXE): $(OBJ)
	$(NVCC) $(OBJ) -o $(EXE) $(LD_FLAGS)

clean:
	rm -rf *.obj $(EXE)

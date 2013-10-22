NB. lasvm hooks for J
NB. Stochastic gradient descent online learning from Leon Battou; 
NB. see README for more information


3 : 0''
if. UNAME-:'Linux' do.
  LASVM=: jpath'~temp/lasvm.so'
elseif. UNAME-:'Darwin' do.  NB. I dunno where darwin keeps things any more
  LASVM=: '"',~'"',jpath '~addons/learning/lasvm/lasvm.dylib'
elseif. do.
  LASVM=: '"',~'"',jpath '~addons/learning/lasvm/lasvm.so', (IF64#'_64'), '.dll'
end.
)

cd=: 15!:0

lasvm_create =: 3 : 0
  'kcache sumflag cp cn'=. y
 cmd=. LASVM,' lasvm_create * * c d d'
 0 pick cmd cd kcache;sumflag;cp;cn
)

lasvm_destroy =: 3 : 0
 cmd=. LASVM,' lasvm_destroy * * c d d'
 0 pick cmd cd y
)

NB. run after processing on SVM to get count
lasvm_get_l =: 3 : 0
 cmd=. LASVM,' lasvm_get_l x *'
 0 pick cmd cd y
)

lasvm_process =: 3 : 0
 'svm i yy' =. y
 cmd=. LASVM,' lasvm_process c * i i'
 ans =. 1
 while. ans = 1 do.
  ans=. 0 pick cmd cd svm;i;yy
 end.
 ans
)


lasvm_reprocess =: 3 : 0
 'svm epsgr' =. y
 cmd=. LASVM,' lasvm_reprocess c * d'
 ans =. 1
 while. ans = 1 do.
  ans=. 0 pick cmd cd svm;epsgr
 end.
 ans
)

lasvm_get_delta =: 3 : 0
 cmd=. LASVM,' lasvm_get_delta d *'
 0 pick cmd cd y
)

lasvm_get_alpha =: 3 : 0
 alpha=. 2.2-2.2
 cmd=. LASVM,' lasvm_get_alpha i * d'
 2 pick cmd cd y;alpha
)

lasvm_get_sv =: 3 : 0
 sv=. 2.2-2.2
 cmd=. LASVM,' lasvm_get_sv i * d'
 2 pick cmd cd y;sv
)

lasvm_get_g =: 3 : 0
 g=. 2.2-2.2
 cmd=. LASVM,' lasvm_get_g i * d'
 2 pick cmd cd y;g
)


lasvm_get_b =: 3 : 0
 cmd=. LASVM,' lasvm_get_b d *'
 0 pick cmd cd y
)

lasvm_get_delta =: 3 : 0
 cmd=. LASVM,' lasvm_get_delta d *'
 0 pick cmd cd y
)

lasvm_get_w2 =: 3 : 0
 cmd=. LASVM,' lasvm_get_w2 d *'
 0 pick cmd cd y
)

lasvm_get_cp =: 3 : 0
 cmd=. LASVM,' lasvm_get_cp d *'
 0 pick cmd cd y
)

lasvm_get_cn =: 3 : 0
 cmd=. LASVM,' lasvm_get_cn d *'
 0 pick cmd cd y
)

lasvm_predict =: 3 : 0
 'svm i' =. y
 cmd=. LASVM,' lasvm_predict d * x'
 0 pick cmd cd svm;i
)

lasvm_predict_nocache =: 3 : 0
 'svm i' =. y
 cmd=. LASVM,' lasvm_predict_nocache d * x'
 0 pick cmd cd svm;i
)

svm_vector_kernel =: 3 : 0

)

NB.    lasvm_kcache_t *kcache=lasvm_kcache_create(kernel, NULL);
NB.    lasvm_kcache_set_maximum_size(kcache, cache_size*1024*1024);

lasvm_kcache_create =: 3 : 0
 'kerkind size' =. y
 cmd=. LASVM,' lasvm_kcache_create * * *'
 kcache=. 0 pick cmd cd (blah blah, function pointer)
 cmd=. LASVM,' lasvm_kcache_set_maximum_size n x'
 cmd cd kcache;size
 kcache
)



lasvm_kcache_destroy =: 3 : 0
 cmd=. LASVM,' lasvm_kcache_destroy * * *'
 0 pick cmd cd y
)

NB. double lasvm_sparsevectorproblem_lin_kernel(int i, int j, void *problem);
lasvm_sparsevector_lin_ker =: 3 : 0
 cmd=. LASCM,' lasvm_sparsevectorproblem_lin_kernel d x x *'
)

NB. double lasvm_sparsevectorproblem_rbf_kernel(int i, int j, void *problem);
NB. will need new constructors here, along with kcache
lasvm_sparsevector_rbf_kernel =: 3 : 0
 cmd=. LASVM,' lasvm_sparsevectorproblem_rbf_kernel d x x *'
)


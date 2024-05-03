! This test checks lowering of `COPYIN` clause.
! Note: The test is autogenerated.

! RUN: bbc -fopenmp -emit-hlfir %s -o - | FileCheck %s
! RUN: %flang_fc1 -emit-hlfir -fopenmp %s -o - | FileCheck %s


! CHECK-LABEL:   func.func @_QPcopyin_scalar_array() {
! CHECK:           %[[VAL_0:.*]] = fir.address_of(@_QFcopyin_scalar_arrayEx1) : !fir.ref<i32>
! CHECK:           %[[VAL_1:.*]]:2 = hlfir.declare %[[VAL_0]] {uniq_name = "_QFcopyin_scalar_arrayEx1"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_2:.*]] = omp.threadprivate %[[VAL_1]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:           %[[VAL_3:.*]]:2 = hlfir.declare %[[VAL_2]] {uniq_name = "_QFcopyin_scalar_arrayEx1"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_4:.*]] = fir.address_of(@_QFcopyin_scalar_arrayEx2) : !fir.ref<!fir.array<10xi64>>
! CHECK:           %[[VAL_5:.*]] = arith.constant 10 : index
! CHECK:           %[[VAL_6:.*]] = fir.shape %[[VAL_5]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_4]](%[[VAL_6]]) {uniq_name = "_QFcopyin_scalar_arrayEx2"} : (!fir.ref<!fir.array<10xi64>>, !fir.shape<1>) -> (!fir.ref<!fir.array<10xi64>>, !fir.ref<!fir.array<10xi64>>)
! CHECK:           %[[VAL_8:.*]] = omp.threadprivate %[[VAL_7]]#1 : !fir.ref<!fir.array<10xi64>> -> !fir.ref<!fir.array<10xi64>>
! CHECK:           %[[VAL_9:.*]] = fir.shape %[[VAL_5]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_10:.*]]:2 = hlfir.declare %[[VAL_8]](%[[VAL_9]]) {uniq_name = "_QFcopyin_scalar_arrayEx2"} : (!fir.ref<!fir.array<10xi64>>, !fir.shape<1>) -> (!fir.ref<!fir.array<10xi64>>, !fir.ref<!fir.array<10xi64>>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_11:.*]] = omp.threadprivate %[[VAL_1]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:             %[[VAL_12:.*]]:2 = hlfir.declare %[[VAL_11]] {uniq_name = "_QFcopyin_scalar_arrayEx1"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_13:.*]] = fir.load %[[VAL_3]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_13]] to %[[VAL_12]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             %[[VAL_14:.*]] = omp.threadprivate %[[VAL_7]]#1 : !fir.ref<!fir.array<10xi64>> -> !fir.ref<!fir.array<10xi64>>
! CHECK:             %[[VAL_15:.*]] = fir.shape %[[VAL_5]] : (index) -> !fir.shape<1>
! CHECK:             %[[VAL_16:.*]]:2 = hlfir.declare %[[VAL_14]](%[[VAL_15]]) {uniq_name = "_QFcopyin_scalar_arrayEx2"} : (!fir.ref<!fir.array<10xi64>>, !fir.shape<1>) -> (!fir.ref<!fir.array<10xi64>>, !fir.ref<!fir.array<10xi64>>)
! CHECK:             hlfir.assign %[[VAL_10]]#0 to %[[VAL_16]]#0 temporary_lhs : !fir.ref<!fir.array<10xi64>>, !fir.ref<!fir.array<10xi64>>
! CHECK:             omp.barrier
! CHECK:             fir.call @_QPsub1(%[[VAL_12]]#1, %[[VAL_16]]#1) fastmath<contract> : (!fir.ref<i32>, !fir.ref<!fir.array<10xi64>>) -> ()
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }

subroutine copyin_scalar_array()
  integer(kind=4), save :: x1
  integer(kind=8), save :: x2(10)
  !$omp threadprivate(x1, x2)

  !$omp parallel copyin(x1) copyin(x2)
    call sub1(x1, x2)
  !$omp end parallel

end

! CHECK-LABEL:   func.func @_QPcopyin_char_chararray() {
! CHECK:           %[[VAL_0:.*]] = fir.address_of(@_QFcopyin_char_chararrayEx3) : !fir.ref<!fir.char<1,5>>
! CHECK:           %[[VAL_1:.*]] = arith.constant 5 : index
! CHECK:           %[[VAL_2:.*]]:2 = hlfir.declare %[[VAL_0]] typeparams %[[VAL_1]] {uniq_name = "_QFcopyin_char_chararrayEx3"} : (!fir.ref<!fir.char<1,5>>, index) -> (!fir.ref<!fir.char<1,5>>, !fir.ref<!fir.char<1,5>>)
! CHECK:           %[[VAL_3:.*]] = omp.threadprivate %[[VAL_2]]#1 : !fir.ref<!fir.char<1,5>> -> !fir.ref<!fir.char<1,5>>
! CHECK:           %[[VAL_4:.*]]:2 = hlfir.declare %[[VAL_3]] typeparams %[[VAL_1]] {uniq_name = "_QFcopyin_char_chararrayEx3"} : (!fir.ref<!fir.char<1,5>>, index) -> (!fir.ref<!fir.char<1,5>>, !fir.ref<!fir.char<1,5>>)
! CHECK:           %[[VAL_5:.*]] = fir.address_of(@_QFcopyin_char_chararrayEx4) : !fir.ref<!fir.array<10x!fir.char<1,5>>>
! CHECK:           %[[VAL_6:.*]] = arith.constant 5 : index
! CHECK:           %[[VAL_7:.*]] = arith.constant 10 : index
! CHECK:           %[[VAL_8:.*]] = fir.shape %[[VAL_7]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_9:.*]]:2 = hlfir.declare %[[VAL_5]](%[[VAL_8]]) typeparams %[[VAL_6]] {uniq_name = "_QFcopyin_char_chararrayEx4"} : (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.shape<1>, index) -> (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.ref<!fir.array<10x!fir.char<1,5>>>)
! CHECK:           %[[VAL_10:.*]] = omp.threadprivate %[[VAL_9]]#1 : !fir.ref<!fir.array<10x!fir.char<1,5>>> -> !fir.ref<!fir.array<10x!fir.char<1,5>>>
! CHECK:           %[[VAL_11:.*]] = fir.shape %[[VAL_7]] : (index) -> !fir.shape<1>
! CHECK:           %[[VAL_12:.*]]:2 = hlfir.declare %[[VAL_10]](%[[VAL_11]]) typeparams %[[VAL_6]] {uniq_name = "_QFcopyin_char_chararrayEx4"} : (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.shape<1>, index) -> (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.ref<!fir.array<10x!fir.char<1,5>>>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_13:.*]] = omp.threadprivate %[[VAL_2]]#1 : !fir.ref<!fir.char<1,5>> -> !fir.ref<!fir.char<1,5>>
! CHECK:             %[[VAL_14:.*]]:2 = hlfir.declare %[[VAL_13]] typeparams %[[VAL_1]] {uniq_name = "_QFcopyin_char_chararrayEx3"} : (!fir.ref<!fir.char<1,5>>, index) -> (!fir.ref<!fir.char<1,5>>, !fir.ref<!fir.char<1,5>>)
! CHECK:             hlfir.assign %[[VAL_4]]#0 to %[[VAL_14]]#0 temporary_lhs : !fir.ref<!fir.char<1,5>>, !fir.ref<!fir.char<1,5>>
! CHECK:             %[[VAL_15:.*]] = omp.threadprivate %[[VAL_9]]#1 : !fir.ref<!fir.array<10x!fir.char<1,5>>> -> !fir.ref<!fir.array<10x!fir.char<1,5>>>
! CHECK:             %[[VAL_16:.*]] = fir.shape %[[VAL_7]] : (index) -> !fir.shape<1>
! CHECK:             %[[VAL_17:.*]]:2 = hlfir.declare %[[VAL_15]](%[[VAL_16]]) typeparams %[[VAL_6]] {uniq_name = "_QFcopyin_char_chararrayEx4"} : (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.shape<1>, index) -> (!fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.ref<!fir.array<10x!fir.char<1,5>>>)
! CHECK:             hlfir.assign %[[VAL_12]]#0 to %[[VAL_17]]#0 temporary_lhs : !fir.ref<!fir.array<10x!fir.char<1,5>>>, !fir.ref<!fir.array<10x!fir.char<1,5>>>
! CHECK:             omp.barrier
! CHECK:             %[[VAL_18:.*]] = fir.emboxchar %[[VAL_14]]#1, %[[VAL_1]] : (!fir.ref<!fir.char<1,5>>, index) -> !fir.boxchar<1>
! CHECK:             %[[VAL_19:.*]] = fir.convert %[[VAL_17]]#1 : (!fir.ref<!fir.array<10x!fir.char<1,5>>>) -> !fir.ref<!fir.char<1,5>>
! CHECK:             %[[VAL_20:.*]] = fir.emboxchar %[[VAL_19]], %[[VAL_6]] : (!fir.ref<!fir.char<1,5>>, index) -> !fir.boxchar<1>
! CHECK:             fir.call @_QPsub2(%[[VAL_18]], %[[VAL_20]]) fastmath<contract> : (!fir.boxchar<1>, !fir.boxchar<1>) -> ()
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }
subroutine copyin_char_chararray()
  character(5), save :: x3, x4(10)
  !$omp threadprivate(x3, x4)

  !$omp parallel copyin(x3) copyin(x4)
    call sub2(x3, x4)
  !$omp end parallel

end

! CHECK-LABEL:   func.func @_QPcopyin_derived_type() {
! CHECK:           %[[VAL_0:.*]] = fir.address_of(@_QFcopyin_derived_typeE.b.my_type.t_arr) : !fir.ref<!fir.array<2x1x!fir.type<_QM__fortran_type_infoTvalue{genre:i8,__padding0:!fir.array<7xi8>,value:i64}>>>
! CHECK:           %[[VAL_1:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_2:.*]] = arith.constant 2 : index
! CHECK:           %[[VAL_3:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_4:.*]] = arith.constant 1 : index
! CHECK:           %[[VAL_5:.*]] = fir.shape_shift %[[VAL_1]], %[[VAL_2]], %[[VAL_3]], %[[VAL_4]] : (index, index, index, index) -> !fir.shapeshift<2>
! CHECK:           %[[VAL_6:.*]]:2 = hlfir.declare %[[VAL_0]](%[[VAL_5]]) {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.b.my_type.t_arr"}
! CHECK:           %[[VAL_7:.*]] = fir.address_of(@_QFcopyin_derived_typeE.n.t_i) : !fir.ref<!fir.char<1,3>>
! CHECK:           %[[VAL_8:.*]] = arith.constant 3 : index
! CHECK:           %[[VAL_9:.*]]:2 = hlfir.declare %[[VAL_7]] typeparams %[[VAL_8]] {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.n.t_i"}
! CHECK:           %[[VAL_10:.*]] = fir.address_of(@_QFcopyin_derived_typeE.n.t_arr) : !fir.ref<!fir.char<1,5>>
! CHECK:           %[[VAL_11:.*]] = arith.constant 5 : index
! CHECK:           %[[VAL_12:.*]]:2 = hlfir.declare %[[VAL_10]] typeparams %[[VAL_11]] {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.n.t_arr"}
! CHECK:           %[[VAL_13:.*]] = fir.address_of(@_QFcopyin_derived_typeE.n.my_type) : !fir.ref<!fir.char<1,7>>
! CHECK:           %[[VAL_14:.*]] = arith.constant 7 : index
! CHECK:           %[[VAL_15:.*]]:2 = hlfir.declare %[[VAL_13]] typeparams %[[VAL_14]] {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.n.my_type"}
! CHECK:           %[[VAL_16:.*]] = fir.address_of(@_QFcopyin_derived_typeEx5) : !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>
! CHECK:           %[[VAL_17:.*]]:2 = hlfir.declare %[[VAL_16]] {uniq_name = "_QFcopyin_derived_typeEx5"} : (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>) -> (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>, !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>)
! CHECK:           %[[VAL_18:.*]] = omp.threadprivate %[[VAL_17]]#1 : !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>> -> !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>
! CHECK:           %[[VAL_19:.*]]:2 = hlfir.declare %[[VAL_18]] {uniq_name = "_QFcopyin_derived_typeEx5"} : (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>) -> (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>, !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>)
! CHECK:           %[[VAL_20:.*]] = fir.address_of(@_QFcopyin_derived_typeE.c.my_type)
! CHECK:           %[[VAL_21:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_22:.*]] = arith.constant 2 : index
! CHECK:           %[[VAL_23:.*]] = fir.shape_shift %[[VAL_21]], %[[VAL_22]] : (index, index) -> !fir.shapeshift<1>
! CHECK:           %[[VAL_24:.*]]:2 = hlfir.declare %[[VAL_20]](%[[VAL_23]]) {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.c.my_type"}
! CHECK:           %[[VAL_25:.*]] = fir.address_of(@_QFcopyin_derived_typeE.dt.my_type)
! CHECK:           %[[VAL_26:.*]]:2 = hlfir.declare %[[VAL_25]] {{{.*}}, uniq_name = "_QFcopyin_derived_typeE.dt.my_type"}
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_27:.*]] = omp.threadprivate %[[VAL_17]]#1 : !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>> -> !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>
! CHECK:             %[[VAL_28:.*]]:2 = hlfir.declare %[[VAL_27]] {uniq_name = "_QFcopyin_derived_typeEx5"} : (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>) -> (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>, !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>)
! CHECK:             hlfir.assign %[[VAL_19]]#0 to %[[VAL_28]]#0 temporary_lhs : !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>, !fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>
! CHECK:             omp.barrier
! CHECK:             fir.call @_QPsub3(%[[VAL_28]]#1) fastmath<contract> : (!fir.ref<!fir.type<_QFcopyin_derived_typeTmy_type{t_i:i32,t_arr:!fir.array<5xi32>}>>) -> ()
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }

subroutine copyin_derived_type()
  type my_type
    integer :: t_i
    integer :: t_arr(5)
  end type my_type
  type(my_type), save :: x5
  !$omp threadprivate(x5)

  !$omp parallel copyin(x5)
    call sub3(x5)
  !$omp end parallel

end

! CHECK-LABEL:   func.func @_QPcombined_parallel_worksharing_loop() {
! CHECK:           %[[VAL_0:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFcombined_parallel_worksharing_loopEi"}
! CHECK:           %[[VAL_1:.*]]:2 = hlfir.declare %[[VAL_0]] {uniq_name = "_QFcombined_parallel_worksharing_loopEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_2:.*]] = fir.address_of(@_QFcombined_parallel_worksharing_loopEx6) : !fir.ref<i32>
! CHECK:           %[[VAL_3:.*]]:2 = hlfir.declare %[[VAL_2]] {uniq_name = "_QFcombined_parallel_worksharing_loopEx6"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_4:.*]] = omp.threadprivate %[[VAL_3]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:           %[[VAL_5:.*]]:2 = hlfir.declare %[[VAL_4]] {uniq_name = "_QFcombined_parallel_worksharing_loopEx6"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_6:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_6]] {uniq_name = "_QFcombined_parallel_worksharing_loopEi"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_8:.*]] = omp.threadprivate %[[VAL_3]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:             %[[VAL_9:.*]]:2 = hlfir.declare %[[VAL_8]] {uniq_name = "_QFcombined_parallel_worksharing_loopEx6"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_10:.*]] = fir.load %[[VAL_5]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_10]] to %[[VAL_9]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             omp.barrier
! CHECK:             %[[VAL_11:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_12:.*]] = fir.load %[[VAL_9]]#0 : !fir.ref<i32>
! CHECK:             %[[VAL_13:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop {
! CHECK-NEXT:          omp.loop_nest (%[[VAL_14:.*]]) : i32 = (%[[VAL_11]]) to (%[[VAL_12]]) inclusive step (%[[VAL_13]]) {
! CHECK:                 fir.store %[[VAL_14]] to %[[VAL_7]]#1 : !fir.ref<i32>
! CHECK:                 fir.call @_QPsub4(%[[VAL_9]]#1) fastmath<contract> : (!fir.ref<i32>) -> ()
! CHECK:                 omp.yield
! CHECK:               }
! CHECK:               omp.terminator
! CHECK:             }
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }

subroutine combined_parallel_worksharing_loop()
  integer, save :: x6
  !$omp threadprivate(x6)

  !$omp parallel do copyin(x6)
    do i=1, x6
      call sub4(x6)
    end do
  !$omp end parallel do

end

! CHECK-LABEL:   func.func @_QPcombined_parallel_sections() {
! CHECK:           %[[VAL_0:.*]] = fir.address_of(@_QFcombined_parallel_sectionsEx7) : !fir.ref<i32>
! CHECK:           %[[VAL_1:.*]]:2 = hlfir.declare %[[VAL_0]] {uniq_name = "_QFcombined_parallel_sectionsEx7"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_2:.*]] = omp.threadprivate %[[VAL_1]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:           %[[VAL_3:.*]]:2 = hlfir.declare %[[VAL_2]] {uniq_name = "_QFcombined_parallel_sectionsEx7"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_4:.*]] = omp.threadprivate %[[VAL_1]]#1 : !fir.ref<i32> -> !fir.ref<i32>
! CHECK:             %[[VAL_5:.*]]:2 = hlfir.declare %[[VAL_4]] {uniq_name = "_QFcombined_parallel_sectionsEx7"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_6:.*]] = fir.load %[[VAL_3]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_6]] to %[[VAL_5]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             omp.barrier
! CHECK:             omp.sections {
! CHECK:               omp.section {
! CHECK:                 fir.call @_QPsub5(%[[VAL_5]]#1) fastmath<contract> : (!fir.ref<i32>) -> ()
! CHECK:                 omp.terminator
! CHECK:               }
! CHECK:               omp.section {
! CHECK:                 fir.call @_QPsub6(%[[VAL_5]]#1) fastmath<contract> : (!fir.ref<i32>) -> ()
! CHECK:                 omp.terminator
! CHECK:               }
! CHECK:               omp.terminator
! CHECK:             }
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }
subroutine combined_parallel_sections()
  integer, save :: x7
  !$omp threadprivate(x7)

  !$omp parallel sections copyin(x7)
    !$omp section
      call sub5(x7)
    !$omp section
      call sub6(x7)
  !$omp end parallel sections

end

! CHECK-LABEL:   func.func @_QPcommon_1() {
! CHECK:           %[[VAL_0:.*]] = fir.address_of(@c_) : !fir.ref<!fir.array<4xi8>>
! CHECK:           %[[VAL_1:.*]] = fir.convert %[[VAL_0]] : (!fir.ref<!fir.array<4xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:           %[[VAL_2:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_3:.*]] = fir.coordinate_of %[[VAL_1]], %[[VAL_2]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:           %[[VAL_4:.*]] = fir.convert %[[VAL_3]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:           %[[VAL_5:.*]]:2 = hlfir.declare %[[VAL_4]] {uniq_name = "_QFcommon_1Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_6:.*]] = omp.threadprivate %[[VAL_0]] : !fir.ref<!fir.array<4xi8>> -> !fir.ref<!fir.array<4xi8>>
! CHECK:           %[[VAL_7:.*]] = fir.convert %[[VAL_6]] : (!fir.ref<!fir.array<4xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:           %[[VAL_8:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_9:.*]] = fir.coordinate_of %[[VAL_7]], %[[VAL_8]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:           %[[VAL_10:.*]] = fir.convert %[[VAL_9]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:           %[[VAL_11:.*]]:2 = hlfir.declare %[[VAL_10]] {uniq_name = "_QFcommon_1Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_12:.*]] = fir.alloca i32 {bindc_name = "y", uniq_name = "_QFcommon_1Ey"}
! CHECK:           %[[VAL_13:.*]]:2 = hlfir.declare %[[VAL_12]] {uniq_name = "_QFcommon_1Ey"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_14:.*]] = omp.threadprivate %[[VAL_0]] : !fir.ref<!fir.array<4xi8>> -> !fir.ref<!fir.array<4xi8>>
! CHECK:             %[[VAL_15:.*]] = fir.convert %[[VAL_14]] : (!fir.ref<!fir.array<4xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:             %[[VAL_16:.*]] = arith.constant 0 : index
! CHECK:             %[[VAL_17:.*]] = fir.coordinate_of %[[VAL_15]], %[[VAL_16]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:             %[[VAL_18:.*]] = fir.convert %[[VAL_17]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:             %[[VAL_19:.*]]:2 = hlfir.declare %[[VAL_18]] {uniq_name = "_QFcommon_1Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_20:.*]] = fir.load %[[VAL_11]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_20]] to %[[VAL_19]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             omp.barrier
! CHECK:             omp.sections {
! CHECK:               omp.section {
! CHECK:                 %[[VAL_21:.*]] = fir.load %[[VAL_19]]#0 : !fir.ref<i32>
! CHECK:                 %[[VAL_22:.*]] = arith.constant 1 : i32
! CHECK:                 %[[VAL_23:.*]] = arith.addi %[[VAL_21]], %[[VAL_22]] : i32
! CHECK:                 hlfir.assign %[[VAL_23]] to %[[VAL_13]]#0 : i32, !fir.ref<i32>
! CHECK:                 omp.terminator
! CHECK:               }
! CHECK:               omp.section {
! CHECK:                 %[[VAL_24:.*]] = fir.load %[[VAL_13]]#0 : !fir.ref<i32>
! CHECK:                 %[[VAL_25:.*]] = fir.load %[[VAL_13]]#0 : !fir.ref<i32>
! CHECK:                 %[[VAL_26:.*]] = arith.muli %[[VAL_24]], %[[VAL_25]] : i32
! CHECK:                 hlfir.assign %[[VAL_26]] to %[[VAL_19]]#0 : i32, !fir.ref<i32>
! CHECK:                 omp.terminator
! CHECK:               }
! CHECK:               omp.terminator
! CHECK:             }
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }
subroutine common_1()
  integer :: x
  integer :: y
  common /c/ x
  !$omp threadprivate(/c/)

  !$omp parallel sections copyin(/c/)
      !$omp section
        y = x + 1
      !$omp section
        x = y * y
  !$omp end parallel sections
end subroutine


! CHECK-LABEL:   func.func @_QPcommon_2() {
! CHECK:           %[[VAL_0:.*]] = fir.alloca i32 {bindc_name = "i", uniq_name = "_QFcommon_2Ei"}
! CHECK:           %[[VAL_1:.*]]:2 = hlfir.declare %[[VAL_0]] {uniq_name = "_QFcommon_2Ei"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_2:.*]] = fir.address_of(@d_) : !fir.ref<!fir.array<8xi8>>
! CHECK:           %[[VAL_3:.*]] = fir.convert %[[VAL_2]] : (!fir.ref<!fir.array<8xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:           %[[VAL_4:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_5:.*]] = fir.coordinate_of %[[VAL_3]], %[[VAL_4]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:           %[[VAL_6:.*]] = fir.convert %[[VAL_5]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:           %[[VAL_7:.*]]:2 = hlfir.declare %[[VAL_6]] {uniq_name = "_QFcommon_2Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_8:.*]] = omp.threadprivate %[[VAL_2]] : !fir.ref<!fir.array<8xi8>> -> !fir.ref<!fir.array<8xi8>>
! CHECK:           %[[VAL_9:.*]] = fir.convert %[[VAL_8]] : (!fir.ref<!fir.array<8xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:           %[[VAL_10:.*]] = arith.constant 0 : index
! CHECK:           %[[VAL_11:.*]] = fir.coordinate_of %[[VAL_9]], %[[VAL_10]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:           %[[VAL_12:.*]] = fir.convert %[[VAL_11]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:           %[[VAL_13:.*]]:2 = hlfir.declare %[[VAL_12]] {uniq_name = "_QFcommon_2Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           %[[VAL_14:.*]] = fir.convert %[[VAL_8]] : (!fir.ref<!fir.array<8xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:           %[[VAL_15:.*]] = arith.constant 4 : index
! CHECK:           %[[VAL_16:.*]] = fir.coordinate_of %[[VAL_14]], %[[VAL_15]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:           %[[VAL_17:.*]] = fir.convert %[[VAL_16]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:           %[[VAL_18:.*]]:2 = hlfir.declare %[[VAL_17]] {uniq_name = "_QFcommon_2Ey"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:           omp.parallel {
! CHECK:             %[[VAL_19:.*]] = fir.alloca i32 {adapt.valuebyref, pinned}
! CHECK:             %[[VAL_20:.*]]:2 = hlfir.declare %[[VAL_19]] {uniq_name = "_QFcommon_2Ei"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_21:.*]] = omp.threadprivate %[[VAL_2]] : !fir.ref<!fir.array<8xi8>> -> !fir.ref<!fir.array<8xi8>>
! CHECK:             %[[VAL_22:.*]] = fir.convert %[[VAL_21]] : (!fir.ref<!fir.array<8xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:             %[[VAL_23:.*]] = arith.constant 0 : index
! CHECK:             %[[VAL_24:.*]] = fir.coordinate_of %[[VAL_22]], %[[VAL_23]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:             %[[VAL_25:.*]] = fir.convert %[[VAL_24]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:             %[[VAL_26:.*]]:2 = hlfir.declare %[[VAL_25]] {uniq_name = "_QFcommon_2Ex"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_27:.*]] = fir.convert %[[VAL_21]] : (!fir.ref<!fir.array<8xi8>>) -> !fir.ref<!fir.array<?xi8>>
! CHECK:             %[[VAL_28:.*]] = arith.constant 4 : index
! CHECK:             %[[VAL_29:.*]] = fir.coordinate_of %[[VAL_27]], %[[VAL_28]] : (!fir.ref<!fir.array<?xi8>>, index) -> !fir.ref<i8>
! CHECK:             %[[VAL_30:.*]] = fir.convert %[[VAL_29]] : (!fir.ref<i8>) -> !fir.ref<i32>
! CHECK:             %[[VAL_31:.*]]:2 = hlfir.declare %[[VAL_30]] {uniq_name = "_QFcommon_2Ey"} : (!fir.ref<i32>) -> (!fir.ref<i32>, !fir.ref<i32>)
! CHECK:             %[[VAL_32:.*]] = fir.load %[[VAL_13]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_32]] to %[[VAL_26]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             %[[VAL_33:.*]] = fir.load %[[VAL_18]]#0 : !fir.ref<i32>
! CHECK:             hlfir.assign %[[VAL_33]] to %[[VAL_31]]#0 temporary_lhs : i32, !fir.ref<i32>
! CHECK:             omp.barrier
! CHECK:             %[[VAL_34:.*]] = arith.constant 1 : i32
! CHECK:             %[[VAL_35:.*]] = fir.load %[[VAL_26]]#0 : !fir.ref<i32>
! CHECK:             %[[VAL_36:.*]] = arith.constant 1 : i32
! CHECK:             omp.wsloop {
! CHECK-NEXT:          omp.loop_nest (%[[VAL_37:.*]]) : i32 = (%[[VAL_34]]) to (%[[VAL_35]]) inclusive step (%[[VAL_36]]) {
! CHECK:                 fir.store %[[VAL_37]] to %[[VAL_20]]#1 : !fir.ref<i32>
! CHECK:                 %[[VAL_38:.*]] = fir.load %[[VAL_31]]#0 : !fir.ref<i32>
! CHECK:                 %[[VAL_39:.*]] = fir.load %[[VAL_20]]#0 : !fir.ref<i32>
! CHECK:                 %[[VAL_40:.*]] = arith.addi %[[VAL_38]], %[[VAL_39]] : i32
! CHECK:                 hlfir.assign %[[VAL_40]] to %[[VAL_31]]#0 : i32, !fir.ref<i32>
! CHECK:                 omp.yield
! CHECK:               }
! CHECK:               omp.terminator
! CHECK:             }
! CHECK:             omp.terminator
! CHECK:           }
! CHECK:           return
! CHECK:         }
subroutine common_2()
  integer :: x
  integer :: y
  common /d/ x, y
  !$omp threadprivate(/d/)
  
  !$omp parallel do copyin(/d/)
     do i = 1, x
        y = y + i
     end do
  !$omp end parallel do
end subroutine
/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

/* This file is designed for use with ISim build 0x7708f090 */

#define XSI_HIDE_SYMBOL_SPEC true
#include "xsi.h"
#include <memory.h>
#ifdef __GNUC__
#include <stdlib.h>
#else
#include <malloc.h>
#define alloca _alloca
#endif
static const char *ng0 = "D:/GitHub/Hierarquia_Mem_mips/MR4 Simplificada e com Hold/mrStd_tb.vhd";
extern char *IEEE_P_3620187407;
extern char *WORK_P_2180760208;

char *ieee_p_3620187407_sub_436279890_3965413181(char *, char *, char *, char *, int );
int ieee_p_3620187407_sub_514432868_3965413181(char *, char *, char *);
char *ieee_p_3620187407_sub_767740470_3965413181(char *, char *, char *, char *, char *, char *);


static void work_a_0312397989_0864436192_p_0(char *t0)
{
    char t1[16];
    char *t2;
    char *t3;
    char *t4;
    char *t5;
    char *t7;
    char *t8;
    char *t9;
    unsigned int t10;
    unsigned int t11;
    unsigned char t12;
    char *t13;
    char *t14;
    char *t15;
    char *t16;
    char *t17;
    char *t18;

LAB0:    xsi_set_current_line(149, ng0);

LAB3:    t2 = (t0 + 1992U);
    t3 = *((char **)t2);
    t2 = (t0 + 2000U);
    t4 = *((char **)t2);
    t5 = (t0 + 24883);
    t7 = (t0 + 3096);
    t7 = *((char **)t7);
    t8 = ieee_p_3620187407_sub_767740470_3965413181(IEEE_P_3620187407, t1, t3, t4, t5, t7);
    t9 = (t1 + 12U);
    t10 = *((unsigned int *)t9);
    t11 = (1U * t10);
    t12 = (32U != t11);
    if (t12 == 1)
        goto LAB5;

LAB6:    t13 = (t0 + 5264);
    t14 = (t13 + 56U);
    t15 = *((char **)t14);
    t16 = (t15 + 56U);
    t17 = *((char **)t16);
    memcpy(t17, t8, 32U);
    xsi_driver_first_trans_fast(t13);

LAB2:    t18 = (t0 + 5136);
    *((int *)t18) = 1;

LAB1:    return;
LAB4:    goto LAB2;

LAB5:    xsi_size_not_matching(32U, t11, 0);
    goto LAB6;

}

static void work_a_0312397989_0864436192_p_1(char *t0)
{
    char *t1;
    char *t2;
    unsigned char t3;
    char *t4;
    char *t5;
    char *t6;
    char *t7;
    char *t8;

LAB0:    xsi_set_current_line(151, ng0);

LAB3:    t1 = (t0 + 2312U);
    t2 = *((char **)t1);
    t3 = *((unsigned char *)t2);
    t1 = (t0 + 5328);
    t4 = (t1 + 56U);
    t5 = *((char **)t4);
    t6 = (t5 + 56U);
    t7 = *((char **)t6);
    *((unsigned char *)t7) = t3;
    xsi_driver_first_trans_fast_port(t1);

LAB2:    t8 = (t0 + 5152);
    *((int *)t8) = 1;

LAB1:    return;
LAB4:    goto LAB2;

}

static void work_a_0312397989_0864436192_p_2(char *t0)
{
    char t17[16];
    char t37[16];
    unsigned char t1;
    char *t2;
    char *t3;
    unsigned char t4;
    unsigned char t5;
    char *t6;
    unsigned char t7;
    unsigned char t8;
    unsigned char t9;
    char *t10;
    unsigned int t11;
    unsigned int t12;
    unsigned int t13;
    char *t14;
    int t15;
    unsigned char t16;
    char *t18;
    char *t19;
    unsigned int t20;
    unsigned int t21;
    unsigned int t22;
    char *t23;
    char *t24;
    int t25;
    char *t26;
    char *t27;
    int t28;
    unsigned char t29;
    char *t30;
    unsigned char t31;
    unsigned char t32;
    char *t33;
    unsigned int t34;
    unsigned int t35;
    unsigned int t36;
    char *t38;
    char *t39;
    unsigned int t40;
    unsigned int t41;
    unsigned int t42;
    char *t43;
    char *t44;
    int t45;
    int t46;
    unsigned int t47;
    unsigned int t48;
    unsigned int t49;
    char *t50;
    char *t51;
    char *t52;
    char *t53;
    char *t54;

LAB0:    xsi_set_current_line(158, ng0);
    t2 = (t0 + 1032U);
    t3 = *((char **)t2);
    t4 = *((unsigned char *)t3);
    t5 = (t4 == (unsigned char)2);
    if (t5 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:
LAB3:    t2 = (t0 + 5168);
    *((int *)t2) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(159, ng0);
    t2 = (t0 + 2632U);
    t10 = *((char **)t2);
    t11 = (31 - 15);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t2 = (t10 + t13);
    t14 = (t0 + 8364U);
    t15 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t2, t14);
    t16 = (t15 >= 0);
    if (t16 == 1)
        goto LAB11;

LAB12:    t9 = (unsigned char)0;

LAB13:    if (t9 != 0)
        goto LAB8;

LAB10:
LAB9:    goto LAB3;

LAB5:    t2 = (t0 + 1192U);
    t6 = *((char **)t2);
    t7 = *((unsigned char *)t6);
    t8 = (t7 == (unsigned char)2);
    t1 = t8;
    goto LAB7;

LAB8:    xsi_set_current_line(160, ng0);
    t26 = (t0 + 1512U);
    t30 = *((char **)t26);
    t31 = *((unsigned char *)t30);
    t32 = (t31 == (unsigned char)3);
    if (t32 != 0)
        goto LAB14;

LAB16:
LAB15:    xsi_set_current_line(165, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t11 = (31 - 7);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t2 = (t3 + t13);
    t6 = (t0 + 2632U);
    t10 = *((char **)t6);
    t20 = (31 - 15);
    t21 = (t20 * 1U);
    t22 = (0 + t21);
    t6 = (t10 + t22);
    t14 = (t0 + 8364U);
    t15 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t6, t14);
    t25 = (t15 - 0);
    t34 = (t25 * 1);
    t35 = (8U * t34);
    t36 = (0U + t35);
    t18 = (t0 + 5392);
    t19 = (t18 + 56U);
    t23 = *((char **)t19);
    t24 = (t23 + 56U);
    t26 = *((char **)t24);
    memcpy(t26, t2, 8U);
    xsi_driver_first_trans_delta(t18, t36, 8U, 0LL);
    goto LAB9;

LAB11:    t18 = (t0 + 2632U);
    t19 = *((char **)t18);
    t20 = (31 - 15);
    t21 = (t20 * 1U);
    t22 = (0 + t21);
    t18 = (t19 + t22);
    t23 = (t0 + 8364U);
    t24 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t17, t18, t23, 3);
    t25 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t24, t17);
    t26 = ((WORK_P_2180760208) + 1168U);
    t27 = *((char **)t26);
    t28 = *((int *)t27);
    t29 = (t25 <= t28);
    t9 = t29;
    goto LAB13;

LAB14:    xsi_set_current_line(161, ng0);
    t26 = (t0 + 2152U);
    t33 = *((char **)t26);
    t34 = (31 - 31);
    t35 = (t34 * 1U);
    t36 = (0 + t35);
    t26 = (t33 + t36);
    t38 = (t0 + 2632U);
    t39 = *((char **)t38);
    t40 = (31 - 15);
    t41 = (t40 * 1U);
    t42 = (0 + t41);
    t38 = (t39 + t42);
    t43 = (t0 + 8364U);
    t44 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t37, t38, t43, 3);
    t45 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t44, t37);
    t46 = (t45 - 0);
    t47 = (t46 * 1);
    t48 = (8U * t47);
    t49 = (0U + t48);
    t50 = (t0 + 5392);
    t51 = (t50 + 56U);
    t52 = *((char **)t51);
    t53 = (t52 + 56U);
    t54 = *((char **)t53);
    memcpy(t54, t26, 8U);
    xsi_driver_first_trans_delta(t50, t49, 8U, 0LL);
    xsi_set_current_line(162, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t11 = (31 - 23);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t2 = (t3 + t13);
    t6 = (t0 + 2632U);
    t10 = *((char **)t6);
    t20 = (31 - 15);
    t21 = (t20 * 1U);
    t22 = (0 + t21);
    t6 = (t10 + t22);
    t14 = (t0 + 8364U);
    t18 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t17, t6, t14, 2);
    t15 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t18, t17);
    t25 = (t15 - 0);
    t34 = (t25 * 1);
    t35 = (8U * t34);
    t36 = (0U + t35);
    t19 = (t0 + 5392);
    t23 = (t19 + 56U);
    t24 = *((char **)t23);
    t26 = (t24 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t2, 8U);
    xsi_driver_first_trans_delta(t19, t36, 8U, 0LL);
    xsi_set_current_line(163, ng0);
    t2 = (t0 + 2152U);
    t3 = *((char **)t2);
    t11 = (31 - 15);
    t12 = (t11 * 1U);
    t13 = (0 + t12);
    t2 = (t3 + t13);
    t6 = (t0 + 2632U);
    t10 = *((char **)t6);
    t20 = (31 - 15);
    t21 = (t20 * 1U);
    t22 = (0 + t21);
    t6 = (t10 + t22);
    t14 = (t0 + 8364U);
    t18 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t17, t6, t14, 1);
    t15 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t18, t17);
    t25 = (t15 - 0);
    t34 = (t25 * 1);
    t35 = (8U * t34);
    t36 = (0U + t35);
    t19 = (t0 + 5392);
    t23 = (t19 + 56U);
    t24 = *((char **)t23);
    t26 = (t24 + 56U);
    t27 = *((char **)t26);
    memcpy(t27, t2, 8U);
    xsi_driver_first_trans_delta(t19, t36, 8U, 0LL);
    goto LAB15;

}

static void work_a_0312397989_0864436192_p_3(char *t0)
{
    char t18[16];
    unsigned char t1;
    unsigned char t2;
    unsigned char t3;
    char *t4;
    char *t5;
    unsigned char t6;
    unsigned char t7;
    char *t8;
    unsigned char t9;
    unsigned char t10;
    char *t11;
    unsigned int t12;
    unsigned int t13;
    unsigned int t14;
    char *t15;
    int t16;
    unsigned char t17;
    char *t19;
    char *t20;
    unsigned int t21;
    unsigned int t22;
    unsigned int t23;
    char *t24;
    char *t25;
    int t26;
    char *t27;
    char *t28;
    int t29;
    unsigned char t30;
    unsigned char t31;
    unsigned char t32;
    char *t33;
    char *t34;
    unsigned char t35;
    unsigned char t36;
    char *t37;
    char *t38;
    char *t39;
    char *t40;

LAB0:    xsi_set_current_line(173, ng0);
    t4 = (t0 + 1032U);
    t5 = *((char **)t4);
    t6 = *((unsigned char *)t5);
    t7 = (t6 == (unsigned char)2);
    if (t7 == 1)
        goto LAB11;

LAB12:    t3 = (unsigned char)0;

LAB13:    if (t3 == 1)
        goto LAB8;

LAB9:    t2 = (unsigned char)0;

LAB10:    if (t2 == 1)
        goto LAB5;

LAB6:    t1 = (unsigned char)0;

LAB7:    if (t1 != 0)
        goto LAB2;

LAB4:    xsi_set_current_line(185, ng0);
    t4 = xsi_get_transient_memory(8U);
    memset(t4, 0, 8U);
    t5 = t4;
    memset(t5, (unsigned char)4, 8U);
    t8 = (t0 + 5520);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    t19 = (t15 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 8U);
    xsi_driver_first_trans_delta(t8, 0U, 8U, 0LL);
    xsi_set_current_line(186, ng0);
    t4 = xsi_get_transient_memory(8U);
    memset(t4, 0, 8U);
    t5 = t4;
    memset(t5, (unsigned char)4, 8U);
    t8 = (t0 + 5520);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    t19 = (t15 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 8U);
    xsi_driver_first_trans_delta(t8, 8U, 8U, 0LL);
    xsi_set_current_line(187, ng0);
    t4 = xsi_get_transient_memory(8U);
    memset(t4, 0, 8U);
    t5 = t4;
    memset(t5, (unsigned char)4, 8U);
    t8 = (t0 + 5520);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    t19 = (t15 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 8U);
    xsi_driver_first_trans_delta(t8, 16U, 8U, 0LL);
    xsi_set_current_line(188, ng0);
    t4 = xsi_get_transient_memory(8U);
    memset(t4, 0, 8U);
    t5 = t4;
    memset(t5, (unsigned char)4, 8U);
    t8 = (t0 + 5520);
    t11 = (t8 + 56U);
    t15 = *((char **)t11);
    t19 = (t15 + 56U);
    t20 = *((char **)t19);
    memcpy(t20, t4, 8U);
    xsi_driver_first_trans_delta(t8, 24U, 8U, 0LL);

LAB3:    t4 = (t0 + 5184);
    *((int *)t4) = 1;

LAB1:    return;
LAB2:    xsi_set_current_line(175, ng0);
    t27 = (t0 + 1632U);
    t32 = xsi_signal_has_event(t27);
    if (t32 == 1)
        goto LAB17;

LAB18:    t31 = (unsigned char)0;

LAB19:    if (t31 != 0)
        goto LAB14;

LAB16:    t4 = (t0 + 1632U);
    t2 = xsi_signal_has_event(t4);
    if (t2 == 1)
        goto LAB22;

LAB23:    t1 = (unsigned char)0;

LAB24:    if (t1 != 0)
        goto LAB20;

LAB21:
LAB15:    goto LAB3;

LAB5:    t19 = (t0 + 2632U);
    t20 = *((char **)t19);
    t21 = (31 - 15);
    t22 = (t21 * 1U);
    t23 = (0 + t22);
    t19 = (t20 + t23);
    t24 = (t0 + 8364U);
    t25 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t18, t19, t24, 3);
    t26 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t25, t18);
    t27 = ((WORK_P_2180760208) + 1168U);
    t28 = *((char **)t27);
    t29 = *((int *)t28);
    t30 = (t26 <= t29);
    t1 = t30;
    goto LAB7;

LAB8:    t4 = (t0 + 2632U);
    t11 = *((char **)t4);
    t12 = (31 - 15);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t4 = (t11 + t14);
    t15 = (t0 + 8364U);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t4, t15);
    t17 = (t16 >= 0);
    t2 = t17;
    goto LAB10;

LAB11:    t4 = (t0 + 1352U);
    t8 = *((char **)t4);
    t9 = *((unsigned char *)t8);
    t10 = (t9 == (unsigned char)2);
    t3 = t10;
    goto LAB13;

LAB14:    xsi_set_current_line(176, ng0);
    t33 = (t0 + 5456);
    t37 = (t33 + 56U);
    t38 = *((char **)t37);
    t39 = (t38 + 56U);
    t40 = *((char **)t39);
    *((unsigned char *)t40) = (unsigned char)3;
    xsi_driver_first_trans_fast(t33);
    xsi_set_current_line(177, ng0);
    t4 = (t0 + 2472U);
    t5 = *((char **)t4);
    t4 = (t0 + 2632U);
    t8 = *((char **)t4);
    t12 = (31 - 15);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t4 = (t8 + t14);
    t11 = (t0 + 8364U);
    t15 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t18, t4, t11, 3);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t15, t18);
    t26 = (t16 - 0);
    t21 = (t26 * 1);
    xsi_vhdl_check_range_of_index(0, 2048, 1, t16);
    t22 = (8U * t21);
    t23 = (0 + t22);
    t19 = (t5 + t23);
    t20 = (t0 + 5520);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t27 = (t25 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t19, 8U);
    xsi_driver_first_trans_delta(t20, 0U, 8U, 0LL);
    xsi_set_current_line(178, ng0);
    t4 = (t0 + 2472U);
    t5 = *((char **)t4);
    t4 = (t0 + 2632U);
    t8 = *((char **)t4);
    t12 = (31 - 15);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t4 = (t8 + t14);
    t11 = (t0 + 8364U);
    t15 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t18, t4, t11, 2);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t15, t18);
    t26 = (t16 - 0);
    t21 = (t26 * 1);
    xsi_vhdl_check_range_of_index(0, 2048, 1, t16);
    t22 = (8U * t21);
    t23 = (0 + t22);
    t19 = (t5 + t23);
    t20 = (t0 + 5520);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t27 = (t25 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t19, 8U);
    xsi_driver_first_trans_delta(t20, 8U, 8U, 0LL);
    xsi_set_current_line(179, ng0);
    t4 = (t0 + 2472U);
    t5 = *((char **)t4);
    t4 = (t0 + 2632U);
    t8 = *((char **)t4);
    t12 = (31 - 15);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t4 = (t8 + t14);
    t11 = (t0 + 8364U);
    t15 = ieee_p_3620187407_sub_436279890_3965413181(IEEE_P_3620187407, t18, t4, t11, 1);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t15, t18);
    t26 = (t16 - 0);
    t21 = (t26 * 1);
    xsi_vhdl_check_range_of_index(0, 2048, 1, t16);
    t22 = (8U * t21);
    t23 = (0 + t22);
    t19 = (t5 + t23);
    t20 = (t0 + 5520);
    t24 = (t20 + 56U);
    t25 = *((char **)t24);
    t27 = (t25 + 56U);
    t28 = *((char **)t27);
    memcpy(t28, t19, 8U);
    xsi_driver_first_trans_delta(t20, 16U, 8U, 0LL);
    xsi_set_current_line(180, ng0);
    t4 = (t0 + 2472U);
    t5 = *((char **)t4);
    t4 = (t0 + 2632U);
    t8 = *((char **)t4);
    t12 = (31 - 15);
    t13 = (t12 * 1U);
    t14 = (0 + t13);
    t4 = (t8 + t14);
    t11 = (t0 + 8364U);
    t16 = ieee_p_3620187407_sub_514432868_3965413181(IEEE_P_3620187407, t4, t11);
    t26 = (t16 - 0);
    t21 = (t26 * 1);
    xsi_vhdl_check_range_of_index(0, 2048, 1, t16);
    t22 = (8U * t21);
    t23 = (0 + t22);
    t15 = (t5 + t23);
    t19 = (t0 + 5520);
    t20 = (t19 + 56U);
    t24 = *((char **)t20);
    t25 = (t24 + 56U);
    t27 = *((char **)t25);
    memcpy(t27, t15, 8U);
    xsi_driver_first_trans_delta(t19, 24U, 8U, 0LL);
    goto LAB15;

LAB17:    t33 = (t0 + 1672U);
    t34 = *((char **)t33);
    t35 = *((unsigned char *)t34);
    t36 = (t35 == (unsigned char)3);
    t31 = t36;
    goto LAB19;

LAB20:    xsi_set_current_line(182, ng0);
    t5 = (t0 + 5456);
    t11 = (t5 + 56U);
    t15 = *((char **)t11);
    t19 = (t15 + 56U);
    t20 = *((char **)t19);
    *((unsigned char *)t20) = (unsigned char)2;
    xsi_driver_first_trans_fast(t5);
    goto LAB15;

LAB22:    t5 = (t0 + 1672U);
    t8 = *((char **)t5);
    t3 = *((unsigned char *)t8);
    t6 = (t3 == (unsigned char)2);
    t1 = t6;
    goto LAB24;

}


extern void work_a_0312397989_0864436192_init()
{
	static char *pe[] = {(void *)work_a_0312397989_0864436192_p_0,(void *)work_a_0312397989_0864436192_p_1,(void *)work_a_0312397989_0864436192_p_2,(void *)work_a_0312397989_0864436192_p_3};
	xsi_register_didat("work_a_0312397989_0864436192", "isim/CPU_tb_isim_beh.exe.sim/work/a_0312397989_0864436192.didat");
	xsi_register_executes(pe);
}

-stack 0xF000

MEMORY
{
#ifdef DSP_CORE
/****************************************************************************/
/*                                                                          */
/*              DSP ר���ڴ�����                                            */
/*                                                                          */
/****************************************************************************/
    DSPL2ROM     o = 0x00700000  l = 0x00100000  /* 1MB   L2 DSP ���� ROM (DSP ROM Bootloader) */
    DSPL2RAM     o = 0x00800000  l = 0x00040000  /* 256kB L2 DSP ���� RAM */
    DSPL1PRAM    o = 0x00E00000  l = 0x00008000  /* 32kB  L1 DSP ���س��� RAM */
    DSPL1DRAM    o = 0x00F00000  l = 0x00008000  /* 32kB  L1 DSP �������� RAM */
#endif

/****************************************************************************/
/*                                                                          */
/*              �����ڴ�����                                                */
/*                                                                          */
/****************************************************************************/
    SHDSPL2ROM   o = 0x11700000  l = 0x00100000  /* 1MB   L2 �������� ROM */
    SHDSPL2RAM   o = 0x11800000  l = 0x00040000  /* 256KB L2 �������� RAM */
    SHDSPL1PRAM  o = 0x11E00000  l = 0x00008000  /* 32KB  L1 �������ó��� RAM */
    SHDSPL1DRAM  o = 0x11F00000  l = 0x00008000  /* 32KB  L1 ������������ RAM */

    EMIFACS0     o = 0x40000000  l = 0x20000000  /* 512MB SDRAM (CS0) */
    EMIFACS2     o = 0x60000000  l = 0x02000000  /* 32MB  �첽          (CS2) */
    EMIFACS3     o = 0x62000000  l = 0x02000000  /* 32MB  �첽          (CS3) */
    EMIFACS4     o = 0x64000000  l = 0x02000000  /* 32MB  �첽          (CS4) */
    EMIFACS5     o = 0x66000000  l = 0x02000000  /* 32MB  �첽          (CS5) */

    SHRAM        o = 0x80000000  l = 0x00020000  /* 128KB ���� RAM */
    DDR2         o = 0xC0001000  l = 0x08000000  /* 128MB  DDR2 ����� DSP */
	
	EntryPoint   o = 0xC0000000  l = 0x00000800  /* 2 KB  C ������ڵ� */
	Vector       o = 0xC0000800  l = 0x00000800  /* 2 KB  �ж������� */

/****************************************************************************/
/*                                                                          */
/*              �����ڴ�����                                                */
/*                                                                          */
/****************************************************************************/
    SYSCFG0      o = 0x01C14000  l = 0x00001000  /* 4K    SYSCFG0 */
    uPP          o = 0x01E16000  l = 0x00001000  /* 4K    uPP */
    GPIO         o = 0x01E26000  l = 0x00001000  /* 4K    GPIO */
    McBSP1       o = 0x01D11000  l = 0x00000800  /* 2K    McBSP1 */

#ifndef DSP_CORE
/****************************************************************************/
/*                                                                          */
/*              ARM ר���ڴ�����                                            */
/*                                                                          */
/****************************************************************************/
    ARMROM       o = 0xFFFD0000  l = 0x00010000  /* 64kB  ARM ���� ROM (ARM ROM Bootloader) */
    ARMRAM       o = 0xFFFF0000  l = 0x00002000  /* 8kB   ARM ���� RAM */
#endif
}

SECTIONS
{
    .text:_c_int00	>  EntryPoint 				 /* ��ִ�д��� C ������ڵ�*/
    .text			>  DDR2 				     /* ��ִ�д��� */
    .stack			>  DDR2 				     /* ����ϵͳջ */
   // .bss			>  DDR2 				     /* δ��ʼ��ȫ�ּ���̬���� */
    .cio			>  DDR2                      /* C ����������� */
    ".vectors"		>  Vector    				 /* �ж������� */
    .const			>  DDR2                      /* ���� */
    .data			>  DDR2                      /* �ѳ�ʼ��ȫ�ּ���̬���� */
    .switch			>  DDR2                      /* ��ת�� */
    .sysmem			>  DDR2                      /* ��̬�ڴ�������� */
    .far			>  DDR2                      /* Զ��ȫ�ּ���̬���� */
    .args			>  DDR2
    .ppinfo			>  DDR2
    .ppdata			>  DDR2

    /* TI-ABI �� COFF */
    .pinit          >  DDR2                      /* C++ �ṹ�� */
    .cinit          >  DDR2                      /* ��ʼ���� */

    /* EABI */
    .binit			>  DDR2
    .init_array		>  DDR2
    //.neardata		>  DDR2
    .fardata		>  DDR2
    //.rodata         >  DDR2
    .c6xabi.exidx	>  DDR2
    .c6xabi.extab	>  DDR2

	GROUP(NEARDP_DATA)
	{
	   .neardata
	   .rodata
	   .bss
	}               >  DDR2
}
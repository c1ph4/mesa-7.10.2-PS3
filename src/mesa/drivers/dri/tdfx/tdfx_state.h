/* -*- mode: c; c-basic-offset: 3 -*-
 *
 * Copyright 2000 VA Linux Systems Inc., Fremont, California.
 *
 * All Rights Reserved.
 *
 * Permission is hereby granted, free of charge, to any person obtaining a
 * copy of this software and associated documentation files (the "Software"),
 * to deal in the Software without restriction, including without limitation
 * the rights to use, copy, modify, merge, publish, distribute, sublicense,
 * and/or sell copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following conditions:
 *
 * The above copyright notice and this permission notice (including the next
 * paragraph) shall be included in all copies or substantial portions of the
 * Software.
 *
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.  IN NO EVENT SHALL
 * VA LINUX SYSTEMS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
 * OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 * SOFTWARE.
 */

/*
 * Original rewrite:
 *	Gareth Hughes <gareth@valinux.com>, 29 Sep - 1 Oct 2000
 *
 * Authors:
 *	Gareth Hughes <gareth@valinux.com>
 *	Brian Paul <brianp@valinux.com>
 *
 */

#ifndef __TDFX_STATE_H__
#define __TDFX_STATE_H__

#include "main/context.h"
#include "tdfx_context.h"

extern void tdfxDDInitStateFuncs( struct gl_context *ctx );

extern void tdfxDDUpdateHwState( struct gl_context *ctx );

extern void tdfxInitState( tdfxContextPtr fxMesa );

extern void tdfxUpdateClipping( struct gl_context *ctx );


extern void tdfxFallback( struct gl_context *ctx, GLuint bit, GLboolean mode );
#define FALLBACK( rmesa, bit, mode ) tdfxFallback( rmesa->glCtx, bit, mode )

extern void tdfxUpdateCull( struct gl_context *ctx );
extern void tdfxUpdateStipple( struct gl_context *ctx );
extern void tdfxUpdateViewport( struct gl_context *ctx );


#endif
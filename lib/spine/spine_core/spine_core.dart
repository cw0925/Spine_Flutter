// ******************************************************************************
// Spine Runtimes Software License v2.5
//
// Copyright (c) 2013-2016, Esoteric Software
// All rights reserved.
//
// You are granted a perpetual, non-exclusive, non-sublicensable, and
// non-transferable license to use, install, execute, and perform the Spine
// Runtimes software and derivative works solely for personal or internal
// use. Without the written permission of Esoteric Software (see Section 2 of
// the Spine Software License Agreement), you may not (a) modify, translate,
// adapt, or develop new applications using the Spine Runtimes or otherwise
// create derivative works or improvements of the Spine Runtimes or (b) remove,
// delete, alter, or obscure any trademarks or any copyright, trademark, patent,
// or other intellectual property or proprietary rights notices on or in the
// Software, including any copy thereof. Redistributions in binary or source
// form must include this license and terms.
//
// THIS SOFTWARE IS PROVIDED BY ESOTERIC SOFTWARE "AS IS" AND ANY EXPRESS OR
// IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF
// MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO
// EVENT SHALL ESOTERIC SOFTWARE BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
// SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO,
// PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES, BUSINESS INTERRUPTION, OR LOSS OF
// USE, DATA, OR PROFITS) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER
// IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
// ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
// POSSIBILITY OF SUCH DAMAGE.
// ******************************************************************************

library spine_core;

import 'dart:convert';
import 'dart:math' as math;
import 'dart:typed_data';

part 'src/animation_state_data.dart';
part 'src/animation_state.dart';
part 'src/animation.dart';
part 'src/atlas_attachment_loader.dart';
part 'src/blend_mode.dart';
part 'src/bone_data.dart';
part 'src/bone.dart';
part 'src/constraint.dart';
part 'src/event.dart';
part 'src/event_data.dart';
part 'src/ik_constraint_data.dart';
part 'src/ik_constraint.dart';
part 'src/path_constraint_data.dart';
part 'src/path_constraint.dart';
part 'src/skeleton_bounds.dart';
part 'src/skeleton_clipping.dart';
part 'src/skeleton_data.dart';
part 'src/skeleton_json.dart';
part 'src/skeleton.dart';
part 'src/skin.dart';
part 'src/slot_data.dart';
part 'src/slot.dart';
part 'src/texture_atlas.dart';
part 'src/texture.dart';
part 'src/transform_constraint_data.dart';
part 'src/transform_constraint.dart';
part 'src/triangulator.dart';
part 'src/updatable.dart';
part 'src/utils.dart';
part 'src/vertex_effect.dart';

part 'src/attachments/attachment_loader.dart';
part 'src/attachments/attachment_type.dart';
part 'src/attachments/attachment.dart';
part 'src/attachments/bounding_box_attachment.dart';
part 'src/attachments/clipping_attachment.dart';
part 'src/attachments/mesh_attachment.dart';
part 'src/attachments/path_attachment.dart';
part 'src/attachments/point_attachment.dart';
part 'src/attachments/region_attachment.dart';
part 'src/vertexeffects/jitter_effect.dart';
part 'src/vertexeffects/swirl_effect.dart';

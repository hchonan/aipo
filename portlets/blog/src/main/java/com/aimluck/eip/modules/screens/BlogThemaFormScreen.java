/*
 * Aipo is a groupware program developed by Aimluck,Inc.
 * Copyright (C) 2004-2008 Aimluck,Inc.
 * http://aipostyle.com/
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program. If not, see <http://www.gnu.org/licenses/>.
 */
package com.aimluck.eip.modules.screens;

import org.apache.jetspeed.services.logging.JetspeedLogFactoryService;
import org.apache.jetspeed.services.logging.JetspeedLogger;
import org.apache.turbine.util.RunData;
import org.apache.velocity.context.Context;

import com.aimluck.eip.blog.BlogThemaFormData;
import com.aimluck.eip.util.ALEipUtils;

/**
 * ブログエントリーを処理するクラスです。 <br />
 * 
 */
public class BlogThemaFormScreen extends ALVelocityScreen {

  /** logger */
  private static final JetspeedLogger logger = JetspeedLogFactoryService
    .getLogger(BlogThemaFormScreen.class.getName());

  /**
   * 
   * @param rundata
   * @param context
   * @throws Exception
   */
  @Override
  protected void doOutput(RunData rundata, Context context) throws Exception {

    try {
      doBlogThema_form(rundata, context);
    } catch (Exception ex) {
      logger.error("[BlogThemaFormScreen] Exception.", ex);
      ALEipUtils.redirectDBError(rundata);
    }
  }

  protected void doBlogThema_form(RunData rundata, Context context) {
    BlogThemaFormData formData = new BlogThemaFormData();
    formData.initField();
    formData.doViewForm(this, rundata, context);

    String layout_template = "portlets/html/ja/ajax-blog-thema-form.vm";
    setTemplate(rundata, context, layout_template);
  }
}

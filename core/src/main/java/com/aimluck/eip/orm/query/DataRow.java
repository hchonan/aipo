/*
 * Aipo is a groupware program developed by Aimluck,Inc.
 * Copyright (C) 2004-2010 Aimluck,Inc.
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
package com.aimluck.eip.orm.query;

import java.util.Map;

/**
 *
 */
public class DataRow extends org.apache.cayenne.DataRow {

  /**
   *
   */
  private static final long serialVersionUID = 7031932120960166286L;

  /**
   * @param initialCapacity
   */
  public DataRow(int initialCapacity) {
    super(initialCapacity);
  }

  /**
   * @param map
   */
  @SuppressWarnings("rawtypes")
  public DataRow(Map map) {
    super(map);
  }

  @Override
  public Object get(Object key) {
    String lowerKey = ((String) key).toLowerCase();
    if (containsKey(lowerKey)) {
      return get(lowerKey);
    } else {
      return get(((String) key).toUpperCase());
    }
  }

  @SuppressWarnings("unchecked")
  public <T> T getValue(String key) {
    return (T) get(key);
  }
}
